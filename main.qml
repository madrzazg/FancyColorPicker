import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Window 2.2

ApplicationWindow {
    title: qsTr("Fancy Color Picker")
    width: 640
    height: 480
    visible: true




    Rectangle{

        anchors.fill: parent


        MouseArea{
            anchors.fill: parent
            onClicked: picker.open()
        }

        FancyColorPicker{
            id: picker
        }
    }
}
