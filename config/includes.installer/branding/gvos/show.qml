import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    Slide {
        Image {
            id: background
            source: "gvosicon.png"
            width: 200
            height: 200
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            anchors.horizontalCenter: background.horizontalCenter
            anchors.top: background.bottom
            anchors.topMargin: 20
            text: "Welcome to GvOS"
            wrapMode: Text.WordWrap
            width: 600
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
            color: "#2c3e50"
        }
        Text {
            anchors.horizontalCenter: background.horizontalCenter
            anchors.top: background.bottom
            anchors.topMargin: 60
            text: "A modern, customizable Debian-based operating system with Windows 11-like aesthetics."
            wrapMode: Text.WordWrap
            width: 600
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 16
            color: "#34495e"
        }
    }

    Slide {
        Text {
            anchors.centerIn: parent
            text: "Features"
            font.pixelSize: 28
            color: "#2c3e50"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            text: "• Windows 11-inspired XFCE desktop\n• Dynamic wallpaper selection\n• Custom Plymouth boot animation\n• Complete sound system\n• Modern dark theme with Papirus icons"
            wrapMode: Text.WordWrap
            width: 600
            font.pixelSize: 16
            color: "#34495e"
            lineHeight: 1.5
        }
    }

    Slide {
        Text {
            anchors.centerIn: parent
            text: "Installing GvOS..."
            font.pixelSize: 24
            color: "#2c3e50"
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            text: "Please wait while GvOS is being installed on your system.\nThis may take several minutes."
            wrapMode: Text.WordWrap
            width: 600
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 16
            color: "#34495e"
        }
    }
}
