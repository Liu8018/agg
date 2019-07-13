import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import agg.WebTool 1.0

ApplicationWindow {
    visible: true;
    width: initialWidth;
    height: initialHeight;
    title: qsTr("agg");
    
    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        
        AggPage {
        }
        
        WebView {
        }
    }
    
    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        
        TabButton {
            text: qsTr("Page 1")
        }
        TabButton {
            text: qsTr("Page 2")
        }
    }
}
