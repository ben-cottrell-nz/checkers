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
        PlayerPiece { gameState: GameState }
    }
    PlayingBoard { gameState: GameState }
}

/*##^##
Designer {
    D{i:0;height:480;width:640}
}
##^##*/

