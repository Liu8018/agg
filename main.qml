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
    }
    
    property int g_toolbarHeight: initialHeight*3/40;
    
    SwipeView {
        id: swipeView;
        anchors.fill: parent;
        onCurrentIndexChanged: {
            if(currentIndex == 2)
                webPage.visible = true;
        }
        
        AggPage {
            toolbarHeight: g_toolbarHeight;
        }
        
        InfoPage {
            id: infoPage;
            currentSite: cSite;
            toolbarHeight: g_toolbarHeight;
            
            onCurrentInfoIdxChanged: {
                webPage.visible = true;
                swipeView.currentIndex = 2;
            }
            
            onBackPageChanged: {
                swipeView.currentIndex = 0;
                backPage = false;
            }
        }
        
        WebPage {
            id: webPage;
            currentUrl: infoPage.currentDetailUrl;
            toolbarHeight: g_toolbarHeight;
            
            onBackPageChanged: {
                swipeView.currentIndex = 1;
                backPage = false;
            }
        }
        
        focus: true;
        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                event.accepted = true;
                
                if(swipeView.currentIndex > 0)
                    swipeView.currentIndex--;
                else
                    Qt.quit();
            }
        }
    }
    
}
