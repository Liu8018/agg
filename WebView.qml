import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls 1.1
import QtWebView 1.1
import QtQuick.Controls.Styles 1.2


Page {
    //ApplicationWindow {
        property bool showProgress: webView.loading
                                    && Qt.platform.os !== "ios"
                                    && Qt.platform.os !== "winrt"
        visible: true
        x: initialX
        y: initialY
        width: initialWidth
        height: initialHeight
        title: webView.title
        
        WebView {
            id: webView
            anchors.fill: parent
            url: initialUrl
            onLoadingChanged: {
                if (loadRequest.errorString)
                    console.error(loadRequest.errorString);
            }
        }
        
        /*
        toolBar: ToolBar {
            id: navigationBar
            RowLayout {
                anchors.fill: parent
                spacing: 0
    
                ToolButton {
                    id: backButton
                    tooltip: qsTr("Back")
                    iconSource: "rcs/images/WebView/left-32.png"
                    onClicked: webView.goBack()
                    enabled: webView.canGoBack
                    Layout.preferredWidth: navigationBar.height
                    style: ButtonStyle {
                        background: Rectangle { color: "transparent" }
                    }
                }
    
                ToolButton {
                    id: forwardButton
                    tooltip: qsTr("Forward")
                    iconSource: "rcs/images/WebView/right-32.png"
                    onClicked: webView.goForward()
                    enabled: webView.canGoForward
                    Layout.preferredWidth: navigationBar.height
                    style: ButtonStyle {
                        background: Rectangle { color: "transparent" }
                    }
                }
    
                ToolButton {
                    id: reloadButton
                    tooltip: webView.loading ? qsTr("Stop"): qsTr("Refresh")
                    iconSource: webView.loading ? "rcs/images/WebView/stop-32.png" : "rcs/images/WebView/refresh-32.png"
                    onClicked: webView.loading ? webView.stop() : webView.reload()
                    Layout.preferredWidth: navigationBar.height
                    style: ButtonStyle {
                        background: Rectangle { color: "transparent" }
                    }
                }
    
                Item { Layout.preferredWidth: 5 }
    
                TextField {
                    Layout.fillWidth: true
                    id: urlField
                    inputMethodHints: Qt.ImhUrlCharactersOnly | Qt.ImhPreferLowercase
                    text: webView.url
    
                    onAccepted: webView.url = utils.fromUserInput(text)
    
                    ProgressBar {
                        anchors.centerIn: parent
                        style: LoadProgressStyle { }
                        z: Qt.platform.os === "android" ? -1 : 1
                        visible: showProgress
                        minimumValue: 0
                        maximumValue: 100
                        value: webView.loadProgress == 100 ? 0 : webView.loadProgress
                    }
                }
    
                Item { Layout.preferredWidth: 5 }
    
                ToolButton {
                    id: goButton
                    text: qsTr("Go")
                    Layout.preferredWidth: navigationBar.height
                    onClicked: {
                        Qt.inputMethod.commit()
                        Qt.inputMethod.hide()
                        webView.url = utils.fromUserInput(urlField.text)
                    }
                    style: ButtonStyle {
                        background: Rectangle { color: "transparent" }
                    }
                }
    
                Item { Layout.preferredWidth: 10 }
            }
        }
    
        statusBar: StatusBar {
            id: statusBar
            visible: showProgress
            RowLayout {
                anchors.fill: parent
                Label { text: webView.loadProgress == 100 ? qsTr("Done") : qsTr("Loading: ") + webView.loadProgress + "%" }
            }
        }
        */
    //}
}
