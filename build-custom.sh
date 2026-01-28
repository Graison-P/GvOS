#!/bin/bash
#
# GvOS Custom ISO Builder
# This script builds the GvOS ISO without relying on problematic live-build wget operations
# It bypasses the Contents-amd64.gz download issue by using debootstrap and manual ISO creation
#

set -e

echo "=== GvOS Custom ISO Builder ==="
echo "Starting custom build process..."

# Configuration
WORK_DIR="$(pwd)/build-custom"
CHROOT_DIR="$WORK_DIR/chroot"
ISO_DIR="$WORK_DIR/iso"
DISTRO="bookworm"
ARCH="amd64"

# Clean previous build
echo "Cleaning previous build..."
sudo rm -rf "$WORK_DIR"
mkdir -p "$CHROOT_DIR" "$ISO_DIR"

# Step 1: Bootstrap base system
echo "Step 1: Bootstrapping Debian $DISTRO base system..."
sudo debootstrap \
    --arch=$ARCH \
    --include=linux-image-amd64,live-boot,systemd-sysv \
    $DISTRO \
    "$CHROOT_DIR" \
    http://ftp.debian.org/debian

# Step 2: Configure APT sources in chroot
echo "Step 2: Configuring APT sources..."
sudo tee "$CHROOT_DIR/etc/apt/sources.list" > /dev/null <<EOF
deb http://ftp.debian.org/debian $DISTRO main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security $DISTRO-security main contrib non-free non-free-firmware
deb http://ftp.debian.org/debian $DISTRO-updates main contrib non-free non-free-firmware
EOF

# Step 3: Install essential packages
echo "Step 3: Installing essential packages..."
sudo chroot "$CHROOT_DIR" /bin/bash -c "
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends \
    xorg \
    xfce4 \
    xfce4-goodies \
    lightdm \
    lightdm-gtk-greeter \
    network-manager \
    network-manager-gnome \
    pulseaudio \
    pavucontrol \
    firefox-esr \
    calamares \
    calamares-settings-debian \
    plymouth \
    plymouth-themes \
    papirus-icon-theme \
    fonts-dejavu \
    live-config \
    live-config-systemd
"

# Step 4: Copy customization files
echo "Step 4: Copying GvOS customization files..."
if [ -d "config/includes.chroot" ]; then
    sudo cp -r config/includes.chroot/* "$CHROOT_DIR/" || true
fi

# Step 5: Run customization hooks
echo "Step 5: Running customization hooks..."
if [ -d "config/hooks/live" ]; then
    for hook in config/hooks/live/*.hook.chroot; do
        if [ -f "$hook" ]; then
            echo "Running hook: $(basename $hook)"
            sudo cp "$hook" "$CHROOT_DIR/tmp/"
            sudo chroot "$CHROOT_DIR" /bin/bash "/tmp/$(basename $hook)" || true
            sudo rm "$CHROOT_DIR/tmp/$(basename $hook)"
        fi
    done
fi

# Step 6: Configure live system
echo "Step 6: Configuring live system..."
sudo chroot "$CHROOT_DIR" /bin/bash -c "
# Set hostname
echo 'gvos-live' > /etc/hostname

# Create live user
useradd -m -s /bin/bash -G sudo,audio,video,plugdev,netdev live || true
echo 'live:live' | chpasswd

# Configure autologin
mkdir -p /etc/lightdm/lightdm.conf.d
cat > /etc/lightdm/lightdm.conf.d/12-autologin.conf <<EOL
[Seat:*]
autologin-user=live
autologin-user-timeout=0
EOL

# Clean up
apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
rm -rf /var/tmp/*
"

# Step 7: Create squashfs filesystem
echo "Step 7: Creating squashfs filesystem..."
mkdir -p "$ISO_DIR/live"
sudo mksquashfs "$CHROOT_DIR" "$ISO_DIR/live/filesystem.squashfs" \
    -comp xz -e boot

# Step 8: Copy kernel and initrd
echo "Step 8: Copying kernel and initrd..."
sudo cp "$CHROOT_DIR/boot/vmlinuz-"* "$ISO_DIR/live/vmlinuz"
sudo cp "$CHROOT_DIR/boot/initrd.img-"* "$ISO_DIR/live/initrd.img"

# Step 9: Create bootloader configuration
echo "Step 9: Creating bootloader configuration..."
mkdir -p "$ISO_DIR/isolinux"

# Copy isolinux files
cp /usr/lib/ISOLINUX/isolinux.bin "$ISO_DIR/isolinux/"
cp /usr/lib/syslinux/modules/bios/* "$ISO_DIR/isolinux/" 2>/dev/null || true

# Create isolinux.cfg
cat > "$ISO_DIR/isolinux/isolinux.cfg" <<EOF
DEFAULT live
PROMPT 0
TIMEOUT 50

LABEL live
  MENU LABEL ^Start GvOS (Live)
  KERNEL /live/vmlinuz
  APPEND initrd=/live/initrd.img boot=live components quiet splash

LABEL live-failsafe
  MENU LABEL Start GvOS (^Failsafe)
  KERNEL /live/vmlinuz
  APPEND initrd=/live/initrd.img boot=live components noapic noapm nodma nomce nolapic nosmp vga=normal
EOF

# Step 10: Create GRUB EFI boot
echo "Step 10: Creating GRUB EFI boot..."
mkdir -p "$ISO_DIR/boot/grub"

cat > "$ISO_DIR/boot/grub/grub.cfg" <<EOF
set default="0"
set timeout=5

menuentry "Start GvOS (Live)" {
    linux /live/vmlinuz boot=live components quiet splash
    initrd /live/initrd.img
}

menuentry "Start GvOS (Failsafe)" {
    linux /live/vmlinuz boot=live components noapic noapm nodma nomce nolapic nosmp
    initrd /live/initrd.img
}
EOF

# Create EFI boot image
mkdir -p "$ISO_DIR/EFI/boot"
grub-mkstandalone \
    --format=x86_64-efi \
    --output="$ISO_DIR/EFI/boot/bootx64.efi" \
    --locales="" \
    --fonts="" \
    "boot/grub/grub.cfg=$ISO_DIR/boot/grub/grub.cfg"

# Step 11: Create ISO image
echo "Step 11: Creating ISO image..."
OUTPUT_ISO="gvos-$(date +%Y%m%d-%H%M%S).iso"

xorriso -as mkisofs \
    -iso-level 3 \
    -full-iso9660-filenames \
    -volid "GVOS_LIVE" \
    -eltorito-boot isolinux/isolinux.bin \
    -eltorito-catalog isolinux/boot.cat \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
    -eltorito-alt-boot \
    -e EFI/boot/bootx64.efi \
    -no-emul-boot \
    -isohybrid-gpt-basdat \
    -output "$OUTPUT_ISO" \
    "$ISO_DIR"

echo "=== Build Complete ==="
echo "ISO created: $OUTPUT_ISO"
echo "Size: $(du -h $OUTPUT_ISO | cut -f1)"

# Make ISO readable by non-root
chmod 644 "$OUTPUT_ISO"

echo "Build finished successfully!"
