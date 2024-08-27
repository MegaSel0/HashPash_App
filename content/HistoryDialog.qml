import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 6.2

Dialog {
    id: historyDialog
    title: qsTr("History")
    modal: true
    width: parent ? parent.width * 0.6 : 320
    height: parent ? parent.height * 0.9 : 240
    visible: false
    anchors {
        centerIn: parent
    }

    ListModel {
        id: historyModel
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        ListView {
            id: historyListView
            anchors.fill: parent
            anchors {
                topMargin: 10
                rightMargin: 10
                leftMargin: 10
                bottomMargin: 10
            }
            model: historyModel
            clip: true

            delegate: SwipeDelegate {
                id: swipeDelegate
                width: historyListView.width
                height: 120

                required property string publicKey
                required property string message
                required property string hash
                required property string dateTime
                required property int id

                contentItem: Rectangle {
                    width: parent.width
                    height: parent.height
                    radius: 8
                    color: "#ffffff"
                    border.color: "#bdbdbd"
                    border.width: 1
                    clip: true

                    Row {
                        spacing: 8
                        width: parent.width
                        height: parent.height
                        padding: 8

                        Column {
                            width: historyListView.width * 0.7
                            Text {
                                text: "Public Key"
                                font.bold: true
                                font.pointSize: 16
                            }

                            Text {
                                text: publicKey.length > 40 ? publicKey.substring(0, 40) + "..." : publicKey
                                font.pointSize: 14
                                color: "#757575"
                            }

                            Text {
                                text: message.length > 20 ? message.substring(0, 20) + "..." : message
                                font.pointSize: 14
                                color: "#757575"
                            }

                        }

                        Rectangle {
                            width: historyListView.width * 0.3
                            height: parent.height
                            color: "transparent"
                            Text {
                                text: dateTime
                                font.pointSize: 10
                                color: "#757575"
                                anchors {
                                    bottom: parent.bottom
                                    right: parent.right
                                    bottomMargin: 8
                                    rightMargin: 55
                                }
                            }
                        }
                    }
                }

                swipe.right: Label {
                    id: deleteLabel
                    text: qsTr("Delete")
                    color: "white"
                    verticalAlignment: Label.AlignVCenter
                    padding: 12
                    width: 100
                    height: parent.height
                    anchors.right: parent.right
                    horizontalAlignment: Label.AlignHCenter
                    SwipeDelegate.onClicked: {
                        console.log("Deleting item with ID:", id);
                        if (sqliteDb) {
                            sqliteDb.deleteData(id);
                        } else {
                            console.error("SQLite database not defined");
                        }
                        historyModel.remove(swipeDelegate.ListView.view.index);
                    }

                    background: Rectangle {
                        color: deleteLabel.SwipeDelegate.pressed ? Qt.darker("red", 1.1) : "red"
                    }
                }

                swipe.left: Label {
                    id: detailsLabel
                    text: qsTr("Details")
                    color: "white"
                    verticalAlignment: Label.AlignVCenter
                    padding: 12
                    width: 100
                    height: parent.height
                    anchors.left: parent.left
                    horizontalAlignment: Label.AlignHCenter
                    SwipeDelegate.onClicked: {
                        // Set itemData and open DetailDialog
                        detailDialog.itemData = {
                            publicKey: publicKey,
                            message: message,
                            hash: hash,
                            dateTime: dateTime
                        };
                        detailDialog.open();
                    }

                    background: Rectangle {
                        color: detailsLabel.SwipeDelegate.pressed ? Qt.darker("steelblue", 1.1) : "steelblue"
                    }
                }
            }
        }

        // حذف RowLayout قبلی
    }

    // اضافه کردن Footer برای دکمه Close
    footer: Button {
        text: qsTr("Close")
        onClicked: historyDialog.close()
        anchors.horizontalCenter: parent.horizontalCenter // دکمه را در مرکز قرار می‌دهد
    }

    Component.onCompleted: {
        console.log("HistoryDialog completed, fetching data...");
        historyModel.clear();
        const data = sqliteDb.fetchData(); // دریافت داده‌ها
        console.log("Fetched Data:", data); // چاپ داده‌ها

        // بررسی داده‌ها و افزودن به مدل
        if (data instanceof Array) {
            for (var i = 0; i < data.length; i++) {
                console.log("Appending:", data[i]); // چاپ هر داده قبل از افزودن به مدل
                historyModel.append(data[i]);
            }
        } else {
            console.log("Error: Data is not in expected format");
        }
    }

    // تعریف DetailDialog
    DetailDialog {
        id: detailDialog
    }
}
