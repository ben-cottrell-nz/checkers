import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12

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
                      anchors.fill: parent
                      drag.target: parent
                      drag.axis: Drag.XAxis | Drag.YAxis
                  }
            sourceClipRect: {
                if ((pieceType | 1) == 1) {
                    return Qt.rect(0, 0, 338, 338)
                } else if ((pieceType | 2) == 2) {
                    return Qt.rect(534, 0, 338, 338)
                }
            }
            source: "qrc:/pieces.png"
        }
    }
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
                property int rowIndex : index
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
                                                             "width": Qt.binding(()=>{return window.cellSize}),
                                                             "height": Qt.binding(()=>{return window.cellSize}),
                                                             "x": Qt.binding(()=>{return col.x + index * window.cellSize}),
                                                             "y": Qt.binding(()=>{return col.y + row.rowIndex * window.cellSize}),
                                                         })
                            } else if (populateP1) {
                                //bottom two rows
                                playerPiece.createObject(window, {
                                                             "pieceType": 1,
                                                             "width": Qt.binding(()=>{return window.cellSize}),
                                                             "height": Qt.binding(()=>{return window.cellSize}),
                                                             "x": Qt.binding(()=>{return col.x + index * window.cellSize}),
                                                             "y": Qt.binding(()=>{return col.y + row.rowIndex * window.cellSize}),
                                                         })
                            }
                        }

                        width: window.cellSize
                        height: window.cellSize
                        border.width: 1
                        color: index % 2 == 0 ? (sy ? "black" : "white") : (sy ? "white" : "black")
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

