import QtQuick 2.15
import QtQuick.Layouts 1.12

Image {
    id: image
    property int cx: 0
    property int cy: 0
    property var board: undefined
    property var gameState: undefined
    x: board.x + (cx * window.cellSize)
    y: board.y + (cy * window.cellSize)
    property int pieceIndex: -1
    property int pieceType: 0

    MouseArea {
        id: ma
        anchors.fill: parent
        enabled: gameState.playerTurnId == 1 && (pieceType & 1) == 1
        drag.target: parent
        drag.axis: Drag.XAxis | Drag.YAxis
        acceptedButtons: Qt.AllButtons
        property int targetCellX: -1
        property int targetCellY: -1
        onReleased: {
            if (gameState.lastHighlightedIndex != -1
                    && gameState.lastHighlightedY != -1) {
                board.children[gameState.lastHighlightedY].children[gameState.lastHighlightedX].children[0].visible = false
                if (targetCellX != -1 && targetCellY != -1) {
                    var piece = gameState.playerPieceQMLItems[image.pieceIndex]
                    console.log(gameState.playerPieceQMLItems)
                    piece.cx = targetCellX
                    piece.cy = targetCellY
                    //hack to recalculate positions for property changes so pieces
                    //snap in place
                    board.x++
                    board.x--
                    board.y++
                    board.y--
                    targetCellX = -1
                    targetCellY = -1

                }
            }
        }
        onPositionChanged: (mouse)=>{
            if (drag.active) {
                var mousePos = mapToGlobal(mouse.x, mouse.y)
                targetCellX = Math.floor(
                            (mousePos.x - window.x - board.x) / window.cellSize)
                targetCellY = Math.floor(
                            (mousePos.y - window.y - board.y) / window.cellSize)
                if ((targetCellX > -1 && targetCellX < 8) && (targetCellY > -1
                                                  && targetCellY < 8)) {
                    gameState.tileState[targetCellX + (targetCellY * 8)] = 3
                    //update the board row column child item
                    var item = board.children[targetCellY].children[targetCellX]
                    if (item instanceof Rectangle) {
                        //remove the highlight from the last highlighted cell
                        if (gameState.lastHighlightedIndex != -1
                                && gameState.lastHighlightedY != -1) {
                                               //highlighted rectangle is
                                               //the rectangle child of the selected row and column
                            board.children[gameState.lastHighlightedY].children[gameState.lastHighlightedX].children[0].visible = false
                        }
                        item.children[0].visible = true
                        gameState.lastHighlightedX = targetCellX
                        gameState.lastHighlightedY = targetCellY
                    }
                }
            }
        }
    }
    sourceClipRect: {
        if (gameState.cf(pieceType, gameState.TS_P1)) {
            //king flag set
            if (gameState.cf(pieceType, gameState.TS_PK)) {
                return Qt.rect(0, 326, 338, 338)
            } else {
                return Qt.rect(0, 0, 338, 338)
            }
        } else if (gameState.cf(pieceType, gameState.TS_P2)) {
            //king flag set
            if (gameState.cf(pieceType, gameState.TS_PK)) {
                return Qt.rect(0, 326, 338, 338)
            } else {
                return Qt.rect(534, 0, 338, 338)
            }
        }
    }
    source: "qrc:/pieces.png"
}
