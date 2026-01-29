#!/bin/bash
# GvOS Sound Event Handler
# This script provides functions to play system sounds based on events
# Can be sourced by window managers, display managers, and system services

# Sound theme directory
SOUND_DIR="/usr/share/sounds"

# Function to play a sound file
play_sound() {
    local sound_file="$1"
    local full_path="$SOUND_DIR/$sound_file"
    
    if [ -f "$full_path" ]; then
        # Try different audio players in order of preference
        if command -v paplay &> /dev/null; then
            paplay "$full_path" &
        elif command -v aplay &> /dev/null; then
            aplay "$full_path" &
        elif command -v ffplay &> /dev/null; then
            ffplay -nodisp -autoexit "$full_path" &>/dev/null &
        fi
    fi
}

# System Events
system_startup() {
    play_sound "startup.wav"
}

system_shutdown() {
    play_sound "shutdown.wav"
}

# Session Events
user_login() {
    play_sound "login.wav"
}

user_logout() {
    play_sound "logout.wav"
}

# Notification Events
notify_error() {
    play_sound "error.wav"
}

notify_warning() {
    play_sound "warning.wav"
}

notify_notice() {
    play_sound "notice.wav"
}

notify_critical() {
    play_sound "critical.wav"
}

# Power Events
battery_low() {
    play_sound "lowbattery.wav"
}

battery_charging() {
    play_sound "charging.wav"
}

# Export functions for use in other scripts
export -f play_sound
export -f system_startup system_shutdown
export -f user_login user_logout
export -f notify_error notify_warning notify_notice notify_critical
export -f battery_low battery_charging
