import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2

Dialog {
    id: detailDialog
    title: qsTr("Details")
    modal: true
    width: 600
    height: 400
    anchors{
        centerIn: parent
    }


    property var itemData: {}

    Rectangle {
        id: rec
        width: parent.width
        height: parent.height
        radius: 10
        color: "#ffffff"
        border.color: "#bdbdbd"
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            spacing: 10
            Layout.margins: 10

            ScrollView {
                Layout.fillHeight: true
                Layout.fillWidth: true // عرض را پر می‌کند
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff // نوار اسکرول افقی خاموش
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff // نوار اسکرول عمودی خاموش

                ColumnLayout {
                    spacing: 10
                    width: rec.width - 20
                    Layout.alignment: Qt.AlignLeft

                    Text {
                        text: "Public Key:"
                        font.bold: true
                        font.pointSize: 16
                        width: parent.width // عرض را محدود کنید
                        wrapMode: Text.WordWrap
                    }

                    Text {
                        text: itemData ? itemData.publicKey : ""
                        wrapMode: Text.WordWrap
                        font.pointSize: 14
                        color: "#757575"
                        width: parent.width // عرض را محدود کنید
                    }

                    Text {
                        text: "Message:"
                        font.bold: true
                        font.pointSize: 16
                        wrapMode: Text.WordWrap
                        width: parent.width // عرض را محدود کنید
                    }

                    Text {
                        text: itemData ? itemData.message : ""
                        wrapMode: Text.WordWrap
                        font.pointSize: 14
                        color: "#757575"
                        width: parent.width // عرض را محدود کنید
                    }

                    Text {
                        text: "Hash:"
                        font.bold: true
                        font.pointSize: 16
                        wrapMode: Text.WordWrap
                        width: parent.width // عرض را محدود کنید
                    }

                    Text {
                        text: itemData ? itemData.hash : ""
                        wrapMode: Text.WordWrap
                        font.pointSize: 14
                        color: "#757575"
                        width: parent.width // عرض را محدود کنید
                    }

                    Text {
                        text: "Date:"
                        font.bold: true
                        font.pointSize: 16
                        wrapMode: Text.WordWrap
                        width: parent.width // عرض را محدود کنید
                    }

                    Text {
                        text: itemData ? itemData.dateTime : ""
                        wrapMode: Text.WordWrap
                        font.pointSize: 14
                        color: "#757575"
                        width: parent.width // عرض را محدود کنید
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
                spacing: 10

                Button {
                    text: qsTr("Close")
                    onClicked: detailDialog.close()
                }
            }
        }
    }

    onOpened: {
        console.log("Detail Dialog opened with item data:", itemData);
    }
}
