import QtQuick 6.2
import QtQuick.Controls 6.2

Item {
    width: parent.width
    height: parent.height

    TextField {
        id: publicKey
        width: parent.width - 40
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 60
        }
        placeholderText: qsTr("Public Key")
    }

    TextArea {
        id: messages
        width: parent.width - 50
        height: 250
        anchors {
            top: publicKey.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }
        wrapMode: TextEdit.Wrap
        placeholderText: qsTr("messages")
    }

    Button {
        id: encryptTheMessage
        text: "Encrypt the message"
        anchors {
            top: messages.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        onClicked: {
                   hashOutput.text = SignVerify.encryptMessage(messages.text, publicKey.text)
               }

    }



    TextArea {
        id: hashOutput
        width: parent.width - 40
        readOnly: true
        anchors {
            top: encryptTheMessage.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        placeholderText: qsTr("Hash Code")
    }
}
