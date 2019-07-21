import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls 1.1

Page {
    property string currentDetailUrl;
    property int currentInfoIdx: -1;
    
    property int toolbarHeight;
    
    property bool backPage: false;
    
    visible: true;
    width: initialWidth;
    height: initialHeight;
    title: qsTr("agg");
    
    ToolBar {
        id: toolBar;
        
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
        
        Text {
            id: siteName;
            
            anchors.left: closeButton.right;
            anchors.verticalCenter: parent.verticalCenter;
            
            text: qsTr(webTool.cSiteName);
        }
        
        ToolButton {
            id: refreshButton;
            
            anchors.right: parent.right;
            anchors.verticalCenter: parent.verticalCenter;
            width: parent.height;
            
            iconSource: "rcs/images/MainInfos_refresh.png";
            
            onClicked: {
                //刷新
            }
        }
        
    }
    
    ScrollView {
        width: parent.width;
        anchors.top: toolBar.bottom;
        anchors.bottom: parent.bottom;
        
        ListView {
            id: listView;
            width: parent.width;
            model: webTool.mainInfoCount;
            delegate: Component {
                Item {
                    width: listView.width;
                    height: initialHeight/6;
                    
                    MouseArea {
                        anchors.fill: parent;
                        width: parent.width;
                        onClicked: {
                            listView.currentIndex = index;
                            currentDetailUrl = webTool.mainDetailUrls[index];
                            currentInfoIdx = index;
                        }
                    }
                    
                    RowLayout {
                        id: rowLayout;
                        anchors.left: parent.left;
                        anchors.leftMargin: 8;
                        anchors.verticalCenter: parent.verticalCenter;
                        height: parent.height;
                        
                        Text {
                            text: webTool.mainInfos[index];
                            width: rowLayout.width;
                            wrapMode: Text.WrapAnywhere;
                            
                            color: "black";
                            
                            Layout.preferredWidth: listView.width*3/4;
                        }
                        
                        Text {
                            text: webTool.mainDates[index];
                            width: rowLayout.width;
                            wrapMode: Text.WrapAnywhere;
                            
                            color: "black";
                            
                            Layout.preferredWidth: listView.width/4;
                        }
                        
                    }
                    
                }
                
            }
            
            focus: true;
            highlight: Rectangle{color: "lightblue";}
            highlightMoveDuration: 0;
        }
    }
}
