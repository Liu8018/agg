import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true;
    width: initialWidth;
    height: initialHeight;
    title: qsTr("agg");
    
    property int g_toolbarHeight: initialHeight*3/40;
    
    SwipeView {
        id: swipeView;
        anchors.fill: parent;
        onCurrentIndexChanged: {
            notificationClient.notification = "hia hia hia...";
        }
        
        AggPage {
            id: aggPage;
            toolbarHeight: g_toolbarHeight;
            
            onButtonClickChanged:  {
                webTool.cSite = currentSite;
                swipeView.currentIndex = 1;
            }
        }
        
        InfoPage {
            id: infoPage;
            toolbarHeight: g_toolbarHeight;
            
            onListClickChanged: {
                swipeView.currentIndex = 2;
            }
            
            onBackPageChanged: {
                if(backPage == true){
                    swipeView.currentIndex = 0;
                    backPage = false;
                }
            }
        }
        
        WebPage {
            id: webPage;
            currentUrl: infoPage.currentDetailUrl;
            toolbarHeight: g_toolbarHeight;
            
            onBackPageChanged: {
                if(backPage == true){
                    swipeView.currentIndex = 1;
                    backPage = false;
                }
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
        
        Component.onCompleted: {
            //contentItem.highlightMoveDuration = 10;
            swipeView.currentIndex = 1;
            swipeView.currentIndex = 0;
        }
        
        interactive: false;
    }
    
}
