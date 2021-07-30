import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import "game_state.js" as GameState

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Draughts")
    property real cellSize: Math.min(window.width * 0.125,
                                     window.height * 0.125)
    Component {
        id: playerPiece
        Image {
            id: image
            property int cx: 0
            property int cy: 0
            x: col.x + cx * window.cellSize
            y: col.y + cy * window.cellSize
            //            width: 32
            //            height: 32
            property int pieceType: 0
            //            Drag.active: mouseArea.drag.active
            //            Drag.dragType: Drag.Automatic
            //            MouseArea {
            //                id: mouseArea
            //                anchors.fill: parent
            //                property point lastPoint: Qt.point(0,0)
            //                property bool isDragging: false
            //                onPressed: {
            //                    isDragging = true
            //                }
            //                onReleased: {
            //                    isDragging = false
            //                    lastPoint = Qt.point(image.x + mouseX, image.y + mouseY)
            //                }
            //                onPositionChanged: {
            //                    if (isDragging) {
            //                        parent.x = image.x + (mouseX - lastPoint.x)
            //                        parent.y = image.y + (mouseY - lastPoint.y)
            //                    }
            //                }

            //            }
            MouseArea {
                id: ma
                anchors.fill: parent
                enabled: GameState.playerTurnId == 1 && (pieceType & 1) == 1
                drag.target: parent
                drag.axis: Drag.XAxis | Drag.YAxis
                onPositionChanged: {
                    if (drag.active) {
                        //derive cx, cy
                        var mousePos = NativeFunctions.globalMousePos()
                        console.log(`${mousePos.x-window.x},${mousePos.y-window.y}`)
                        //console.log("dragging")
                    }
                }
            }
            sourceClipRect: {
                if ((pieceType & 1) == 1) {
                    //king flag set
                    if ((pieceType & 4) == 4) {
                        return Qt.rect(0, 326, 338, 338)
                    } else {
                        return Qt.rect(0, 0, 338, 338)
                    }
                } else if ((pieceType & 2) == 2) {
                    //king flag set
                    if ((pieceType & 4) == 4) {
                        return Qt.rect(0, 326, 338, 338)
                    } else {
                        return Qt.rect(534, 0, 338, 338)
                    }
                }
            }
            source: "qrc:/pieces.png"
        }
    }
    //    Rectangle {
    //        color: "blue"
    //        width: col.x
    //        height: window.height
    //    }

    //    Rectangle {
    //        color: "blue"
    //        width: 512
    //        height: 512
    //        MouseArea {
    //            id: mouseArea
    //            anchors.fill: parent
    //            property point lastPoint: Qt.point(0,0)
    //            property bool isDragging: false
    //            onPressed: {
    //                isDragging = true
    //            }
    //            onReleased: {
    //                isDragging = false
    //                lastPoint = Qt.point(mouseX, mouseY)
    //            }

    //            onMouseXChanged: {
    //                if (isDragging) {
    //                parent.x = mouseX - lastPoint.x
    //                }
    //            }
    //            onMouseYChanged: {
    //                if (isDragging) {
    //                parent.y = mouseY - lastPoint.y
    //                }
    //            }
    //        }
    //    }
    Column {
        id: col
        anchors.centerIn: parent
        Repeater {
            model: 8
            delegate: Row {
                id: row
                property bool populateP2: index < 2
                property bool populateP1: index > 5 && index < 8
                property bool sy: index % 2 == 0
                property int rowIndex: index
                Repeater {
                    model: 8
                    Rectangle {
                        id: cellRect
                        Component.onCompleted: {
                            var p2OffsetX = 543
                            //top two rows
                            if (populateP2) {
                                playerPiece.createObject(window, {
                                                             "pieceType": 2,
                                                             "width": Qt.binding(
                                                                          () => {
                                                                              return window.cellSize
                                                                          }),
                                                             "height": Qt.binding(
                                                                           () => {
                                                                               return window.cellSize
                                                                           }),
                                                             "cx": index,
                                                             "cy": row.rowIndex
                                                         })
                            } else if (populateP1) {
                                //bottom two rows
                                playerPiece.createObject(window, {
                                                             "pieceType": 1,
                                                             "width": Qt.binding(
                                                                          () => {
                                                                              return window.cellSize
                                                                          }),
                                                             "height": Qt.binding(
                                                                           () => {
                                                                               return window.cellSize
                                                                           }),
                                                             "cx": index,
                                                             "cy": row.rowIndex
                                                         })
                            }
                        }
                        width: window.cellSize
                        height: window.cellSize
                        border.width: 1
                        color: index % 2
                               == 0 ? (sy ? "#dd9160" : "white") : (sy ? "white" : "#dd9160")
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;height:480;width:640}
}
##^##*/

