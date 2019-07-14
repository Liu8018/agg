import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import agg.WebTool 1.0

ApplicationWindow {
    visible: true;
    width: initialWidth;
    height: initialHeight;
    title: qsTr("agg");
    
    property string cSite: "zdh";
    onCSiteChanged: {
        swipeView.currentIndex = 1;
        //tabBar.currentIndex = 1;
    }
    
    SwipeView {
        id: swipeView;
        anchors.fill: parent;
        //currentIndex: tabBar.currentIndex;
        onCurrentIndexChanged: {
            if(currentIndex == 2)
                webPage.visible = true;
            //tabBar.currentIndex = currentIndex;
        }
        
        AggPage {
            
        }
        
        InfoPage {
            id: infoPage;
            currentSite: cSite;
            
            onCurrentInfoIdxChanged: {
                webPage.visible = true;
                swipeView.currentIndex = 2;
                //tabBar.currentIndex = 2;
            }
        }
        
        WebPage {
            id: webPage;
            currentUrl: infoPage.currentDetailUrl;
        }
    }
    
    /*
    footer: TabBar {
        id: tabBar;
        visible: true;
        currentIndex: swipeView.currentIndex;
        onCurrentIndexChanged: {
            swipeView.currentIndex = currentIndex;
        }
        
        TabButton {
            text: qsTr("Page 0")
        }
        TabButton {
            text: qsTr("Page 1")
        }
        TabButton {
            text: qsTr("Page 2")
        }
    }
    */
}
