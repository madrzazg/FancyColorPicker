import QtQuick 2.4

FocusScope {
    id: scope
    visible: false
    scale: 0
    focus: false

    x: root.x
    y: root.y
    width: root.width
    height: root.height

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

    Rectangle {
        id: root
        width: grid.implicitWidth
        height: grid.implicitHeight

        property string selectedColor

        Grid{
            id: grid
            spacing: 5

            Repeater{
                model: scope.model

                Rectangle{
                    width: 50
                    height: 50
                    radius: 25
                    color: scope.model[index]
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

