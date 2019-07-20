import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls 1.1

Page {
    property string currentSite;
    
    property int toolbarHeight;
    
    property bool webButtonClicked: false;
    
    ToolBar {
        id: toolBar;
        
        anchors.top: parent.top;
        width: parent.width;
        height: toolbarHeight;
        
        ToolButton {
            id: menuButton;
            
            anchors.left: parent.left;
            anchors.verticalCenter: parent.verticalCenter;
            width: parent.height;
            
            iconSource: "rcs/images/menu.png";
        }
        
        ToolButton {
            id: webButton;
            
            anchors.right: parent.right;
            anchors.verticalCenter: parent.verticalCenter;
            width: parent.height;
            
            iconSource: "rcs/images/web.png";
            
            onClicked: {
                webButtonClicked = true;
            }
        }
    }
    
    ToolButton {
        id: testButton1;
        
        width: toolbarHeight;
        height: toolbarHeight;
        anchors.left: parent.left;
        anchors.top: toolBar.bottom;
        
        iconSource: "rcs/siteIcons/jwc.png";
        
        onClicked: {
            currentSite = "jwc";
        }
    }
    ToolButton {
        id: testButton2;
        
        width: toolbarHeight;
        height: toolbarHeight;
        anchors.left: testButton1.right;
        anchors.top: toolBar.bottom;
        
        iconSource: "rcs/siteIcons/zdh.png";
        
        onClicked: {
            currentSite = "zdh";
        }
    }
}
