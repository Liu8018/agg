import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls 1.1
import QtWebView 1.1
import QtQuick.Controls.Styles 1.2

Page {
    property string currentUrl;
    onCurrentUrlChanged: {
        webView.url = currentUrl;
    }
    
    property int toolbarHeight: initialHeight/10;
    
    visible: false;
    x: initialX;
    y: initialY;
    width: initialWidth;
    height: initialHeight;
    title: webView.title;
    
    WebView {
        id: webView;
        anchors.top: inputUrlBar.bottom;
        anchors.bottom: navigationBar.top;
        width: parent.width;
        
        url: currentUrl;
        onLoadingChanged: {
            if (loadRequest.errorString)
                console.error(loadRequest.errorString);
        }
    }
    
    ToolBar {
        id: inputUrlBar;
        width: parent.width;
        height: toolbarHeight*3/4;
        anchors.top: parent.top;
        
        TextField {
            id: urlField
            
            anchors.left: parent.left;
            width: parent.width*3/4;
            anchors.verticalCenter: parent.verticalCenter;
            
            /*
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
            */
        }
        
        ToolButton {
            id: goButton
            
            anchors.left: urlField.right;
            anchors.right: parent.right;
            anchors.verticalCenter: parent.verticalCenter;
            
            text: qsTr("Go")
            
            /*
            onClicked: {
                Qt.inputMethod.commit()
                Qt.inputMethod.hide()
                webView.url = utils.fromUserInput(urlField.text)
            }
            */
            
            style: ButtonStyle {
                background: Rectangle { color: "transparent" }
            }
        }
    }
    
    ToolBar {
        id: navigationBar;
        
        width: parent.width;
        height: toolbarHeight;
        anchors.bottom: parent.bottom;
        
        ToolButton {
            id: backButton
            
            width: toolbarHeight;
            height: toolbarHeight;
            anchors.right: reloadButton.left;
            anchors.verticalCenter: parent.verticalCenter;
            
            tooltip: qsTr("Back")
            iconSource: "rcs/images/WebView/left-32.png"

            onClicked: webView.goBack()
            enabled: webView.canGoBack
            style: ButtonStyle {
                background: Rectangle { color: "transparent" }
            }
        }
        
        ToolButton {
            id: reloadButton
            
            width: toolbarHeight;
            height: toolbarHeight;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter: parent.horizontalCenter;
            
            tooltip: webView.loading ? qsTr("Stop"): qsTr("Refresh")
            iconSource: webView.loading ? "rcs/images/WebView/stop-32.png" : "rcs/images/WebView/refresh-32.png"
            onClicked: webView.loading ? webView.stop() : webView.reload()
            style: ButtonStyle {
                background: Rectangle { color: "transparent" }
            }
        }
        
        ToolButton {
            id: forwardButton
            
            width: toolbarHeight;
            height: toolbarHeight;
            anchors.left: reloadButton.right;
            anchors.verticalCenter: parent.verticalCenter;
            
            tooltip: qsTr("Forward")
            iconSource: "rcs/images/WebView/right-32.png"
            onClicked: webView.goForward()
            enabled: webView.canGoForward
            style: ButtonStyle {
                background: Rectangle { color: "transparent" }
            }
        }
        
    }
}
