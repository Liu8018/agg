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
    
    property int toolbarHeight;
    
    property bool showProgress: webView.loading
                                && Qt.platform.os !== "ios"
                                && Qt.platform.os !== "winrt"
    
    property bool backPage: false;
    
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
        height: toolbarHeight;
        anchors.top: parent.top;
        
        ToolButton {
            id: closeButton;
            
            anchors.left: parent.left;
            anchors.verticalCenter: parent.verticalCenter;
            width: parent.height;
            
            iconSource: "rcs/images/window-close.png";
            
            onClicked: {
                backPage = true;
            }
        }
        
        TextField {
            id: urlField
            
            anchors.left: parent.left;
            anchors.leftMargin: parent.width/8;
            anchors.verticalCenter: parent.verticalCenter;
            
            width: parent.width*3/4;
            
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
        
        ToolButton {
            id: goButton
            
            anchors.left: urlField.right;
            anchors.right: parent.right;
            anchors.verticalCenter: parent.verticalCenter;
            
            text: qsTr("Go")
            
            onClicked: {
                Qt.inputMethod.commit()
                Qt.inputMethod.hide()
                webView.url = utils.fromUserInput(urlField.text)
            }
            
            style: ButtonStyle {
                background: Rectangle { color: "transparent" }
            }
        }
    }
    
    ToolBar {
        id: navigationBar;
        
        width: parent.width;
        height: toolbarHeight*5/4;
        anchors.bottom: parent.bottom;
        
        ToolButton {
            id: backButton
            
            width: toolbarHeight;
            height: toolbarHeight;
            anchors.right: reloadButton.left;
            anchors.verticalCenter: parent.verticalCenter;
            
            tooltip: qsTr("Back")
            iconSource: "rcs/images/left.png"

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
            iconSource: webView.loading ? "rcs/images/stop.png" : "rcs/images/refresh.png"
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
            iconSource: "rcs/images/right.png"
            onClicked: webView.goForward()
            enabled: webView.canGoForward
            style: ButtonStyle {
                background: Rectangle { color: "transparent" }
            }
        }
        
    }
    
}
