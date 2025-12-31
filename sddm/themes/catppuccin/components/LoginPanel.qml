import QtQuick
import QtQuick.Window
import QtQuick.Controls

Item {
    property var user: userPanel.username
    property var password: passwordField.text
    property var session: sessionPanel.session
    property var inputHeight: Screen.height * config.LoginScale * 0.25
    property var inputWidth: Screen.width * config.LoginScale

    Column {
        spacing: 8

        anchors {
            bottom: parent.bottom
            left: parent.left
        }

        PowerPanel {
            id: powerPanel
        }

        SessionPanel {
            id: sessionPanel
        }
    }

    Column {
        spacing: 8

        width: inputWidth
        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        UserPanel {
            id: userPanel
        }

        PasswordPanel {
            id: passwordField

            height: inputHeight
            width: parent.width

            onAccepted: loginButton.clicked()
        }

        Button {
            id: loginButton

            height: inputHeight
            width: parent.width

            enabled: user != "" && password != "" ? true : false
            hoverEnabled: true
            text: "Login!!"

            contentItem: Text {
                id: buttonText

                renderType: Text.NativeRendering
                font.family: config.Font
                font.pointSize: 26
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                color: "#ffffff"
                opacity: 1
                text: config.LoginButtonText

		// ADD SHADOW
                style: Text.Outline           
                styleColor: "#000000"
            }

            background: Rectangle {
                id: buttonBackground

                color: config.LoginButtonBgColor
                opacity: 1
                radius: config.CornerRadius
            }

            Rectangle {
                id: loginAnim

                radius: parent.width / 2
                anchors.centerIn: loginButton
                color: "black"
                opacity: 1

                NumberAnimation {
                    id: coverScreen

                    target: loginAnim
                    properties: "height, width"
                    from: 0
                    to: root.width * 2
                    duration: 1000
                    easing.type: Easing.InExpo
                }
            }

            states: [
                State {
                    name: "pressed"
                    when: loginButton.down
                    PropertyChanges {
                        target: buttonBackground
                        color: Qt.darker(config.LoginButtonBgColor, 1.4)
                        opacity: 1
                    }
                    PropertyChanges {
                        target: buttonText
                        opacity: 1
                    }
                },
                State {
                    name: "hovered"
                    when: loginButton.hovered
                    PropertyChanges {
                        target: buttonBackground
                        color: Qt.darker(config.LoginButtonBgColor, 1.2)
                        opacity: 1
                    }
                    PropertyChanges {
                        target: buttonText
                        opacity: 1
                    }
                },
                State {
                    name: "enabled"
                    when: loginButton.enabled
                    PropertyChanges {
                        target: buttonBackground
                        opacity: 1
                    }
                    PropertyChanges {
                        target: buttonText
                        opacity: 1
                    }
                }
            ]

            transitions: Transition {
                PropertyAnimation {
                    properties: "color, opacity"
                    duration: 150
                }
            }

            onClicked: {
                sddm.login(user, password, session)
            }
        }
    }

    Connections {
        target: sddm
        function onLoginSucceeded() {
            coverScreen.start()
        }
        function onLoginFailed() {
            passwordField.text = ""
            passwordField.focus = true
        }
    }
}
