import QtQuick 2.4
import QtGraphicalEffects 1.0

FocusScope {
    id: scope
    visible: false
    scale: 0
    focus: false

    width: 220
    height: 220


    /* This property holds the model that is used to populate available colors pallete. It can hold up to 9 colors, passed as simple list or ListModel.
    */
    property var model: ["#DFBC5A", "#B451A9", "#72C864", "#81F2E1", "#177047", "#8C4D29", "#67162E", "#DCE428", "#FD7256"]

    /* This signal is emitted when user selects color.
    */
    signal colorSelected(string color)


    function open(){
        root.state = "SHOWN"
    }

    function close(){
        root.state = ""
    }

    DropShadow{
        anchors.fill: scope
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8
        samples: 16
        color: "#80000000"
        source: root
    }


    Rectangle {
        id: root
        anchors.fill: parent
        radius: width/2

        property string selectedColor

        Grid{
            id: grid
            spacing: 5
            focus: true
            columns: 3
            rows: 3
            rotation: 45
            anchors.centerIn: parent

            Repeater{
                model: scope.model

                Rectangle{
                    id: delegate
                    width: 50
                    height: 50
                    radius: width / 2
                    color: scope.model[index]

                    MouseArea{
                        anchors.fill: parent
                        onClicked:{
                            root.selectedColor = delegate.color
                            scope.colorSelected(root.selectedColor)
                        }
                    }
                }
            }
        }

        states: State {
            name: "SHOWN"
            PropertyChanges {
                target: scope
                visible: true
                scale: 1
                focus: true
            }
        }

        transitions: Transition {
            from: ""
            to: "SHOWN"
            reversible: true

            SequentialAnimation {
                PropertyAnimation { target: scope; property: "visible"; duration: 0 }
                PropertyAnimation { target: scope; property: "scale"; duration: 150 }
            }
        }
    }
}

