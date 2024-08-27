import QtQuick 6.2
import QtQuick.Controls 6.2
import Test_1

Item {
    width: parent.width
    height: parent.height

    CustomTextField {
        id: privateKey
        width: parent.width - 40
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 60
        }

        textInput{
            id:privateKeyText
        }
        placeholderText: qsTr("Private Key")
        Connections {
                target: encryptionDialog
                onPrivateKeyUpdated: privateKeyText.text = newPrivateKey
        }
    }

    CustomTextField {
        id: hashCode
        width: parent.width - 40
        anchors {
            top: privateKey.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        placeholderText: qsTr("Encrypted Message")
    }

    CustomTextArea {
        id: messages
        width: parent.width - 50
        height: 250

        anchors {
            top: hashCode.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }
        textInput{
            readOnly:true
        }

        placeholderText: qsTr("Decrypted Message")
    }

    CustomPressEffectButton {
        id: verifyTheMessage
        text: "Decrypt the message"
        anchors {
            top: messages.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        buttonMouseArea{
            onClicked: {
                var decryptedMessage = SignVerify.decryptMessage(hashCode.text, privateKey.text);
                messages.text = decryptedMessage;

                // ذخیره‌سازی اطلاعات دی‌هش در پایگاه داده
                sqliteDb.insertDecryptionData(privateKey.text, decryptedMessage, hashCode.text);
            }
        }
    }

}
