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
    
    SwipeView {
        id: swipeView;
        anchors.fill: parent;
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
                swipeView.currentIndex = 2;
            }
        }
        
        WebPage {
            id: webPage;
            currentUrl: infoPage.currentDetailUrl;
            
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
