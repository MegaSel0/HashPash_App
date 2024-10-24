import QtQuick 6.2
import QtQuick.Controls 6.2
import Test_1

Item {
    width: parent.width
    height: parent.height




    CustomTextField {
        id: publicKey
        width: parent.width - 40
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 60
        }

        textInput {
            id: publicKeyText


        }
        placeholderText: qsTr("Public Key")
    }

    CustomTextArea {
        id: messages
        width: parent.width - 50
        height: 220
        anchors {
            top: publicKey.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }

        textInput {
            id: messagesText
        }

        placeholderText: qsTr("messages")
    }

    CustomPressEffectButton {
        id: encryptTheMessage
        text: "Encrypt"
        anchors {
            top: messages.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }

        SequentialAnimation {
            id: shakeAnimation
            loops: 2
            running: false
            NumberAnimation { target: parent; property: "x"; from: parent.x; to: parent.x + 10; duration: 50 }
            NumberAnimation { target: parent; property: "x"; from: parent.x + 10; to: parent.x - 10; duration: 50 }
            NumberAnimation { target: parent; property: "x"; from: parent.x - 10; to: parent.x; duration: 50 }
            onStopped: {
                parent.x = 0
            }
        }

        buttonMouseArea {
            onClicked: {
                handleSendButtonClicked()

                if (notification.visible) {

                    shakeAnimation.start()
                } else {

                    var hash = SignVerify.encryptMessage(messages.text, publicKey.text)
                    hashOutput.text = hash
                    sqliteDb.insertData(publicKey.text, messages.text, hash)
                    historyDialog.updateHistoryModel();
                }
            }
        }


    }

    CustomTextField {
        id: hashOutput
        width: parent.width - 40
        textInput {
            id: textInput
            readOnly: true
        }

        anchors {
            top: encryptTheMessage.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        placeholderText: qsTr("Hash Code")
        Item {
            anchors.fill: parent

            Rectangle {
                id: tooltip
                width: 150
                height: 40
                color: "#333333"
                radius: 5
                opacity: 0.8
                visible: false
                z: 1

                Text {
                    id: tooltipText
                    anchors.centerIn: parent
                    color: "white"
                    text: "Copy Code"
                }
            }

            ToolButton {
                id: copyButton
                icon.source: "images/copy.svg"
                icon.color: "#ffffff"
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                onClicked: {
                    clipboardHelper.copyText(textInput.text);
                    tooltipText.text = "Copied!"
                    tooltip.visible = true
                    hideTooltipTimer.start()
                }
                clip:true
            }

            Timer {
                id: hideTooltipTimer
                interval: 1000
                running: false
                repeat: false
                onTriggered: {
                    tooltipText.text = "Copy Code"
                    tooltip.visible = false
                }
            }

            MouseArea {
                id: hoverArea
                anchors.fill: copyButton
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true

                onEntered: {
                    if (!tooltip.visible && tooltipText.text !== "Copied!") {
                        tooltip.visible = true
                        tooltip.x = copyButton.x + copyButton.width / 2 - tooltip.width / 2
                        tooltip.y = copyButton.y - tooltip.height - 5
                    }
                }

                onExited: {
                    if (tooltipText.text !== "Copied!") {
                        tooltip.visible = false
                    }
                }

                onClicked: {
                    copyButton.clicked()
                }
            }
        }

        }


    Rectangle {
        id: notification
        width: parent.width
        height: 50
        color: "red"
        radius: 5
        anchors {
            top: parent.top
            topMargin: 50
        }
        visible: false
        opacity: 0.0

        Text {
            id: notificationText
            anchors.centerIn: parent
            color: "white"
            text: ""
            font.pixelSize: 16
        }


        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }


        Timer {
            id: hideNotificationTimer
            interval: 3000
            repeat: false
            onTriggered: notification.hide()
        }


        function show(message) {
            notificationText.text = message
            notification.visible = true
            notification.opacity = 1.0
            hideNotificationTimer.start()
        }


        function hide() {
            notification.opacity = 0.0
            notification.visible = false
        }
    }

    function handleSendButtonClicked() {
        if (messagesText.text === "" && publicKeyText.text === "") {
            notification.show("Public Key and messages cannot be empty.")
        } else if (publicKeyText.text === "") {
            notification.show("Public Key cannot be empty.")
        } else if (messagesText.text === "") {
            notification.show("messages cannot be empty.")
        } else if (!publicKeyText.text.includes("-----BEGIN PUBLIC KEY-----") ||
                   !publicKeyText.text.includes("-----END PUBLIC KEY-----")) {
            notification.show("Public key syntax is not correct.")
        }
    }
}
