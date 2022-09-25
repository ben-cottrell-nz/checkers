var playerTurnId = 1
const TS_P1 = 1
const TS_P2 = 2
const TS_PK = 4
var lastHighlightedX = -1
var lastHighlightedY = -1
var tileState = [
    TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,
    TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,
    TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,
    TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1
]
/*
This contains an array of associative properties: pieceType, cx, cy, and pieceIndex.
pieceIndex is the index in playerPieceQMLItems. It's used in onReleased function.
cx, cy are positions on the board.
  */
var playerPieceQMLItems = []
function cf(value, flag) {
    return (value & flag) === flag
}
