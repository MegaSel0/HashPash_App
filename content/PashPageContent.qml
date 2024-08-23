import QtQuick 6.2
import QtQuick.Controls 6.2

Item {
    width: parent.width
    height: parent.height

    TextField {
        id: privateKey
        width: parent.width - 40
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 60
        }
        placeholderText: qsTr("Private Key")
    }

    TextArea {
        id: hashCode
        width: parent.width - 40
        anchors {
            top: privateKey.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        placeholderText: qsTr("Encrypted Message")
    }

    TextArea {
        id: messages
        width: parent.width - 50
        height: 250
        readOnly: true
        anchors {
            top: hashCode.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 30
        }
        wrapMode: TextEdit.Wrap
        placeholderText: qsTr("Decrypted Message")
    }

    Button {
        id: verifyTheMessage
        text: "Decrypt the message"
        anchors {
            top: messages.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: 15
        }
        onClicked: {
            var decryptedMessage = SignVerify.decryptMessage(hashCode.text, privateKey.text);
            messages.text = decryptedMessage;

            // ذخیره‌سازی اطلاعات دی‌هش در پایگاه داده
            sqliteDb.insertDecryptionData(privateKey.text, decryptedMessage, hashCode.text);
        }
    }

}
