import QtQuick
import QtQuick.Controls

Column {
    spacing: 0

    Text {
        id: dateLabel

        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 1

        renderType: Text.NativeRendering
        font.family: config.Font
        font.pointSize: config.DateSize
        font.bold: config.DateIsBold == "true" ? true : false
        color: "#ffffff"
	style: Text.Outline
        styleColor: "#000000"

        function updateDate() {
            text = new Date().toLocaleDateString(Qt.locale(), config.DateFormat)
        }
    }

    Text {
        id: timeLabel

        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 1

        renderType: Text.NativeRendering
        font.family: config.Font
        font.pointSize: config.TimeSize
        font.bold: config.TimeIsBold == "true" ? true : false
        color: "#ffffff"
	style: Text.Outline
        styleColor: "#000000"

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(), config.TimeFormat)
        }
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            timeLabel.updateTime()
            dateLabel.updateDate()
        }
    }

    Component.onCompleted: {
        timeLabel.updateTime()
        dateLabel.updateDate()
    }
}
