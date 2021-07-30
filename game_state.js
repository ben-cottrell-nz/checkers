var playerTurnId = 1;
const TS_P1 = 1;
const TS_P2 = 2;
const TS_PK = 4;
var lastHighlightedX = -1;
var lastHighlightedY = -1;

var tileState = [
    TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,
    TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,TS_P2,
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,
    TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,
    TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1,TS_P1
];
function cf(value, flag) {
    return (value & flag) === flag;
}
