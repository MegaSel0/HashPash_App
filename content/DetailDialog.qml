import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2
import Test_1

CustomDialog {
    id: detailDialog
    backgroundColor: "#3d3d3d"
    property var itemData: {}
    showCloseButton: false
    anchors.centerIn: parent
    height: parent.height

    Rectangle {
        id: rec
        width: parent.width
        height: parent.height / 1.1
        radius: 20
        color: "#3d3d3d"
        border.color: "#3d3d3d"
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            spacing: 10


            Rectangle {
                width: parent.width / 1.1
                height: 40
                anchors{
                    horizontalCenter: parent.horizontalCenter
                }

                color: "#3d3d3d"
                radius: 20

                Text {
                    text: "Details"
                    font.bold: true
                    font.pointSize: 18
                    color: "#ffffff"
                    anchors.centerIn: parent
                }
            }

            ScrollView {
                Layout.fillHeight: true
                Layout.fillWidth: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AlwaysOff

                ColumnLayout {
                    spacing: 10
                    width: rec.width - 20
                    Layout.alignment: Qt.AlignLeft

                    Text {
                        text: "Public Key:"
                        font.bold: true
                        font.pointSize: 16
                        width: parent.width
                        wrapMode: Text.WordWrap
                        color: "#ffffff"
                    }

                    TextArea {
                        text: itemData ? itemData.publicKey : ""
                        wrapMode: Text.WordWrap
                        font.pointSize: 14
                        color: "#cccccc"
                        width: parent.width
                        readOnly: true
                        background: null
                        padding: 0
                    }


                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#757575"
                        opacity: 0.5
                    }

                    Text {
                        text: "Message:"
                        font.bold: true
                        font.pointSize: 16
                        width: parent.width
                        wrapMode: Text.WordWrap
                        color: "#ffffff"
                    }

                    TextArea {
                        text: itemData ? itemData.message : ""
                        wrapMode: Text.WordWrap
                        font.pointSize: 14
                        color: "#cccccc"
                        width: parent.width
                        readOnly: true
                        background: null
                        padding: 0
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#757575"
                        opacity: 0.5
                    }

                    Text {
                        text: "Hash:"
                        font.bold: true
                        font.pointSize: 16
                        width: parent.width
                        wrapMode: Text.WordWrap
                        color: "#ffffff"
                    }

                    TextArea {
                        text: itemData ? itemData.hash : ""
                        wrapMode: Text.WordWrap
                        font.pointSize: 14
                        color: "#cccccc"
                        width: parent.width
                        readOnly: true
                        background: null
                        padding: 0
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#757575"
                        opacity: 0.5
                    }

                    Text {
                        text: "Date:"
                        font.bold: true
                        font.pointSize: 16
                        width: parent.width
                        wrapMode: Text.WordWrap
                        color: "#ffffff"
                    }

                    TextArea {
                        text: itemData ? itemData.dateTime : ""
                        wrapMode: Text.WordWrap
                        font.pointSize: 14
                        color: "#cccccc"
                        width: parent.width
                        readOnly: true
                        background: null
                        padding: 0
                    }

                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#757575"
                        opacity: 0.5
                    }
                }
            }
        }
    }

    ToolButton {
        icon.source: "images/close.svg"
        icon.color: "Red"
        width: 50
        height: 50
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            detailDialog.visible = false
        }
    }
}
