import QtQuick 6.2
import QtQuick.Controls 6.2

Page {
    id: root
    width: parent.width
    height: parent.height

    StackView {
        id: stackView
        initialItem: Qt.resolvedUrl("PashPageForm.ui.qml")
        anchors.fill: parent
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: "lightblue"

        Text {
            anchors.centerIn: parent
            text: "This is Page 2"
        }
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
