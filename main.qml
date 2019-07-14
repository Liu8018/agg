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
        tabBar.currentIndex = 1;
    }
    
    SwipeView {
        id: swipeView;
        anchors.fill: parent;
        currentIndex: tabBar.currentIndex;
        onCurrentIndexChanged: {
            if(currentIndex == 2)
                webPage.visible = true;
        }
        
        AggPage {
            
        }
        
        InfoPage {
            id: infoPage;
            currentSite: cSite;
            
            onCurrentInfoIdxChanged: {
                webPage.visible = true;
                tabBar.currentIndex = 2;
            }
        }
        
        WebPage {
            id: webPage;
            currentUrl: infoPage.currentDetailUrl;
        }
    }
    
    footer: TabBar {
        id: tabBar;
        currentIndex: swipeView.currentIndex;
        
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
}
