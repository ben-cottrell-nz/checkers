import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12

Column {
    id: board
    property var gameState: undefined
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
                    //this is shown when dragging a piece over
                    Rectangle {
                        id: highlightRect
                        property real alpha: visible ? 1 : 0
                        color: Qt.rgba(0,1,1,alpha)
                        Behavior on alpha {
                            NumberAnimation { properties: "alpha"; duration: 66 }
                        }
                        visible: false
                        anchors.fill: parent
                    }

                    id: cellRect
                    Component.onCompleted: {
                        //top two rows
                        var tileState = gameState.tileState[index + (row.rowIndex * 8)]
                        var isPlayerPiece = false
                        if (gameState.cf(tileState, gameState.TS_P1)) {
                            isPlayerPiece = true
                        } else if (gameState.cf(tileState,
                                                gameState.TS_P2)) {
                            isPlayerPiece = true
                        }
                        if (isPlayerPiece) {
                            gameState.playerPieceQMLItems.push(
                                        playerPiece.createObject(window, {
                                                                     "pieceType": tileState,
                                                                     "board" : Qt.binding(()=> { return board }),
                                                                     "width": Qt.binding(() => {
                                                                                             return window.cellSize
                                                                                         }),
                                                                     "height": Qt.binding(
                                                                                   () => {
                                                                                       return window.cellSize
                                                                                   }),
                                                                     "cx": index,
                                                                     "cy": row.rowIndex,
                                                                     "pieceIndex" : gameState.playerPieceQMLItems.length
                                                                 }))
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
