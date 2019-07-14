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
    
    visible: false;
    x: initialX;
    y: initialY;
    width: initialWidth;
    height: initialHeight;
    title: webView.title;
    
    WebView {
        id: webView;
        anchors.fill: parent;
        url: currentUrl;
        onLoadingChanged: {
            if (loadRequest.errorString)
                console.error(loadRequest.errorString);
        }
    }
    
}
