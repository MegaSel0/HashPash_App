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
        placeholderText: qsTr("Public Key")
    }

    CustomTextArea {
        id: messages
        width: parent.width - 50
        height: 250
        anchors {
            top: publicKey.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }
        placeholderText: qsTr("messages")
    }

    CustomPressEffectButton {
        id: encryptTheMessage
        text: "Encrypt the message"
        anchors {
            top: messages.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        buttonMouseArea {
            onClicked: {
                var hash = SignVerify.encryptMessage(messages.text, publicKey.text)
                hashOutput.text = hash
                sqliteDb.insertData(publicKey.text, messages.text, hash)
            }
        }
    }

    CustomTextField {
        id: hashOutput
        width: parent.width - 40
        textInput{
            id:textInput
            readOnly:true

        }

        anchors {
            top: encryptTheMessage.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        placeholderText: qsTr("Hash Code")

        Item {
            anchors.fill: parent

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
                }
            }

        }
    }
}
