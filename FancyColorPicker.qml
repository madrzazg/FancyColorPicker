import QtQuick 2.4
import QtGraphicalEffects 1.0

FocusScope {
    id: scope
    visible: false
    scale: 0
    focus: false

    width: 240
    height: 240


    /* This property holds the model that is used to populate available colors pallete. It can hold up to 9 colors, passed as simple list or ListModel.
    */
    property var model: ["#DFBC5A", "#B451A9", "#72C864", "#81F2E1", "#177047", "#8C4D29", "#67162E", "#DCE428", "#FD7256"]

    /* This signal is emitted when user selects color.
    */
    signal colorSelected(string color)


    /* This function opens dialog at given position. Function calculates x,y values so that when dialog is openned, it is centered both vertically and horizontally.
    */
    function open(mouseX, mouseY){
        scope.x = mouseX - scope.width / 2
        scope.y = mouseY - scope.height / 2
        root.state = "SHOWN"
    }

    function close(){
        root.state = ""
    }

    //Shadow effect to provide layers experience
    DropShadow{
        anchors.fill: scope
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8
        samples: 16
        color: "#80000000"
        source: root
    }


    // White area with grid
    Rectangle {
        id: root
        anchors.fill: parent
        radius: width/2

        property string selectedColor

        Grid{
            id: grid
            spacing: 10
            focus: true
            columns: 3
            rows: 3
            anchors.centerIn: parent

            property int currentIndex: 0

            Keys.onRightPressed: {
                currentIndex = (currentIndex + 1) % 9
            }

            Keys.onLeftPressed: {
                --currentIndex
                if (currentIndex < 0){
                    currentIndex = 8
                }
            }

            Keys.onDownPressed: {
                currentIndex = (currentIndex + 3) % 9
            }

            Keys.onUpPressed: {
                currentIndex -= 3
                if (currentIndex < 0){
                    currentIndex = 9 - Math.abs(currentIndex)
                }
            }

            Keys.onSpacePressed: {
                root.selectedColor = model[currentIndex]
                update()
                scope.colorSelected(root.selectedColor)
                scope.close()
            }

            Keys.onEscapePressed: {
                scope.close()
            }


            Repeater{
                model: scope.model

                Rectangle{
                    id: delegate
                    width: 50
                    height: 50
                    radius: width / 2
                    color: scope.model[index]
                    scale: grid.currentIndex === index? 1.2 : 1
                    border.width: 1
                    border.color: root.selectedColor == color? "black" : "transparent"

                    MouseArea{
                        id: delegateMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked:{
                            root.selectedColor = delegate.color
                            scope.colorSelected(root.selectedColor)
                            scope.close()
                        }

                        onContainsMouseChanged: {
                            if (containsMouse){
                                grid.currentIndex = index
                            }
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

