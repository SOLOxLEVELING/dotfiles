import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

TextField {
    id: usernameField

    height: inputHeight
    width: inputWidth
    selectByMouse: true
    echoMode: TextInput.Normal
    selectionColor: config.TextFieldTextColor

    renderType: Text.NativeRendering
    font.family: config.Font
    font.pointSize: 26
    font.bold: true
    color: "#ffffff"
    horizontalAlignment: Text.AlignHCenter	

    placeholderText: config.UserFieldBgText
    text: userModel.lastUser

    background: Rectangle {
        id: userFieldBackground

        color: "#1e1e2e"
        border.color: config.TextFieldHighlightColor
        border.width: 2
        radius: config.CornerRadius
    }

    states: [
        State {
            name: "focused"
            when: usernameField.activeFocus
            PropertyChanges {
                target: userFieldBackground
                color: Qt.darker(config.TextFieldColor, 1.2)
                border.width: config.TextFieldHighlightWidth
            }
        },
        State {
            name: "hovered"
            when: usernameField.hovered
            PropertyChanges {
                target: userFieldBackground
                color: Qt.darker(config.TextFieldColor, 1.2)
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            properties: "color, border.width"
            duration: 150
        }
    }
}
