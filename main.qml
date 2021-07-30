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
            x: board.x + cx * window.cellSize
            y: board.y + cy * window.cellSize
            property int pieceType: 0
            MouseArea {
                id: ma
                anchors.fill: parent
                enabled: GameState.playerTurnId == 1 && (pieceType & 1) == 1
                drag.target: parent
                drag.axis: Drag.XAxis | Drag.YAxis
                onReleased: {
                    if (GameState.lastHighlightedIndex != -1
                            && GameState.lastHighlightedY != -1) {
                        board.children[GameState.lastHighlightedY].children[GameState.lastHighlightedX].children[0].visible = false
                    }
                }

                onPositionChanged: {
                    if (drag.active) {
                        //derive cx, cy
                        var mousePos = NativeFunctions.globalMousePos()
                        var cellX = Math.floor(
                                    (mousePos.x - window.x - board.x) / window.cellSize)
                        var cellY = Math.floor(
                                    (mousePos.y - window.y - board.y) / window.cellSize)
                        if ((cellX > -1 && cellX < 8) && (cellY > -1
                                                          && cellY < 8)) {
                            GameState.tileState[cellX + (cellY * 8)] = 3
                            //update the board row column child item
                            var item = board.children[cellY].children[cellX]
                            if (item instanceof Rectangle) {
                                //remove the highlight from the last highlighted cell
                                if (GameState.lastHighlightedIndex != -1
                                        && GameState.lastHighlightedY != -1) {
                                    board.children[GameState.lastHighlightedY].children[GameState.lastHighlightedX].children[0].visible = false
                                }
                                item.children[0].visible = true
                                console.log(`${item.children[1].id}`)
                                GameState.lastHighlightedX = cellX
                                GameState.lastHighlightedY = cellY
                            }
                        }
                    }
                }
            }
            sourceClipRect: {
                if (GameState.cf(pieceType, GameState.TS_P1)) {
                    //king flag set
                    if (GameState.cf(pieceType, GameState.TS_PK)) {
                        return Qt.rect(0, 326, 338, 338)
                    } else {
                        return Qt.rect(0, 0, 338, 338)
                    }
                } else if (GameState.cf(pieceType, GameState.TS_P2)) {
                    //king flag set
                    if (GameState.cf(pieceType, GameState.TS_PK)) {
                        return Qt.rect(0, 326, 338, 338)
                    } else {
                        return Qt.rect(534, 0, 338, 338)
                    }
                }
            }
            source: "qrc:/pieces.png"
        }
    }
    Column {
        id: board
        anchors.centerIn: parent
        Repeater {
            //rows
            model: 8
            delegate: Row {
                id: row
                property bool sy: index % 2 == 0
                property int rowIndex: index
                Repeater {
                    //columns
                    model: 8
                    Rectangle {
                        Rectangle {
                            id: highlightRect
                            color: "yellow"
                            visible: false
                            anchors.fill: parent
                        }

                        id: cellRect
                        Component.onCompleted: {
                            //top two rows
                            var tileState = GameState.tileState[index + (row.rowIndex * 8)]
                            var isPlayerPiece = false
                            //                            console.log(`ts: ${tileState}`)
                            if (GameState.cf(tileState, GameState.TS_P1)) {
                                //                                    console.log("P1")
                                isPlayerPiece = true
                            } else if (GameState.cf(tileState,
                                                    GameState.TS_P2)) {
                                //                                    console.log("P2")
                                isPlayerPiece = true
                            }
                            if (isPlayerPiece) {
                                playerPiece.createObject(window, {
                                                             "pieceType": tileState,
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

