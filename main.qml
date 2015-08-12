/****************************************************************************
**  Example application to show how to use FancyColorPicker component.
**  Author: Mateusz Drzazga
**  Email: matt.drzazga@gmail.com
**
****************************************************************************/

import QtQuick 2.3
import QtQuick.Controls 1.3

ApplicationWindow {
    title: qsTr("Fancy Color Picker")
    width: 640
    height: 480
    visible: true
    id: mainWindow


    Rectangle {
        color: "lightgrey"
        anchors.fill: parent
        focus: true

        Keys.onSpacePressed: console.log("main.qml space pressed")

        Rectangle {
            id: colorIndicator
            width: 50
            height: 50
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        MouseArea {
            anchors.fill: parent
            onClicked: picker.open(mouseX, mouseY)
        }

        FancyColorPicker {
            id: picker
            onColorSelected: colorIndicator.color = color
        }
    }

    Rectangle {
        width: 150
        height: 150
        x: 300
        y: 300
        color: "red"
    }
}
