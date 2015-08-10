import QtQuick 2.3

FocusScope {
    id: scope

    property var model: ["#DFBC5A", "#B451A9", "#72C864", "#81F2E1", "#177047", "#8C4D29", "#67162E", "#DCE428", "#FD7256"]
    signal colorSelected(string color)


    Rectangle{
        id: root

        property string selectedColor




    }
}

