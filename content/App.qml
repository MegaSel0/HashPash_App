import QtQuick 6.2
import QtQuick.Controls 6.2
import Test_1

ApplicationWindow {
    id: root

    width: 900
    height: 600
    minimumHeight: 400
    maximumHeight: 600
    minimumWidth: 400
    maximumWidth: 900
    visible: true
    property var builtInStyles

    color:"Black"

    // Container for the animated image and main content
    Item {
        id: container
        width: root.width
        height: root.height

        // Animated image
        AnimatedImage {
            id: animatedImage
            source: "animation/ZZ6.gif"
            anchors.fill: parent
            opacity: 0

            Behavior on opacity {
                NumberAnimation { from: 0; to: 1; duration: 1000 }
            }
        }

        Timer {
            id: transitionTimer
            interval: 3000
            running: true
            repeat: false
            onTriggered: {
                // Ensure animation is hidden after the timer
                animatedImage.opacity = 0
                mainContent.visible = true
            }
        }

        Component.onCompleted: {
            // Start the animation when the component is loaded
            animatedImage.opacity = 1
        }

        // صفحه اصلی که پس از انیمیشن نمایش داده می‌شود
        HashPage {
            id: mainContent
            visible: false  // Initially hidden and shown after the animation
            anchors.fill: parent


        }
    }
}
