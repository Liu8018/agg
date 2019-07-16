import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls 1.1

Page {
    property int toolbarHeight;
    
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
        }
    }
}
