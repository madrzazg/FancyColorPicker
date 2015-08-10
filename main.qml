import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Window 2.2

ApplicationWindow {
    title: qsTr("Fancy Color Picker")
    width: 640
    height: 480
    visible: true


    FancyColorPicker{
        id: picker
    }

    Rectangle{
        color: "blue"
        anchors.fill: parent


        MouseArea{
            anchors.fill: parent
        }
    }
}
