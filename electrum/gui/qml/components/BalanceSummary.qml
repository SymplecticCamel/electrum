import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

Frame {
    id: root
    height: layout.height

    property string formattedBalance
    property string formattedUnconfirmed

    function setBalances() {
        root.formattedBalance = Config.formatSats(Daemon.currentWallet.confirmedBalance, true)
        root.formattedUnconfirmed = Config.formatSats(Daemon.currentWallet.unconfirmedBalance, true)
    }

    GridLayout {
        id: layout

        columns: 2
        Label {
            font.pixelSize: constants.fontSizeLarge
            text: qsTr('Balance: ')
        }
        Label {
            font.pixelSize: constants.fontSizeLarge
            color: Material.accentColor
            text: formattedBalance
        }
        Label {
            font.pixelSize: constants.fontSizeMedium
            text: qsTr('Confirmed: ')
        }
        Label {
            font.pixelSize: constants.fontSizeMedium
            color: Material.accentColor
            text: formattedBalance
        }
        Label {
            font.pixelSize: constants.fontSizeMedium
            text: qsTr('Unconfirmed: ')
        }
        Label {
            font.pixelSize: constants.fontSizeMedium
            color: Material.accentColor
            text: formattedUnconfirmed
        }
    }

    Connections {
        target: Config
        function onBaseUnitChanged() { setBalances() }
        function onThousandsSeparatorChanged() { setBalances() }
    }

    Connections {
        target: Daemon
        function onWalletLoaded() { setBalances() }
    }

    Component.onCompleted: setBalances()
}
