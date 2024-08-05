import QtQuick 6.2
import QtQuick.Controls 6.2

Page {
    id: root

    width: parent.width
    height: parent.height
    SwipeView {
        id: view
        anchors.fill: parent

        Loader {
            id: firstPageLoader
            source: Qt.resolvedUrl("HashPageContent.qml")
        }

        Loader {
            id: secondPageLoader
            source: Qt.resolvedUrl("PashPageContent.qml")
        }
    }

    PageIndicator {
        id: indicator
        count: view.count
        currentIndex: view.currentIndex
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 50
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        spacing: 10
        width: parent.width



        Button {
            text: "HashPage"
            width: parent.width / 2
            height: 50
            background: Rectangle {
                color: parent.pressed ? "#555555" : "steelBlue"
                border.color: "transparent"
                radius: 0
            }
            font.pixelSize: 18
            onClicked: {
                view.currentIndex = 0
            }
        }
        Button {
            text: "PashPage"
            width: parent.width / 2
            height: 50
            background: Rectangle {
                color: parent.pressed ? "#555555" : "steelBlue"
                border.color: "transparent"
                radius: 0
            }
            font.pixelSize: 18
            onClicked: {
                view.currentIndex = 1
            }
        }
    }
}
