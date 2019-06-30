import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import agg.WebTool 1.0

ApplicationWindow {
    visible: true;
    //width: initialWidth;
    //height: initialHeight;
    title: qsTr("agg");
    
    /*
    property variant mainInfos;
    property variant mainDates;
    property variant mainDetailUrls;
    */
    
    WebTool {
        id: webTool;
        cSite: "zdh";
        
        /*
        Component.onCompleted: {
            mainInfos = webTool.mainInfos;
            mainDates = webTool.mainDates;
            mainDetailUrls = webTool.mainDetailUrls;
        }
        */
    }
    
    
    ScrollView {
        anchors.fill: parent;
        
        ListView {
            id: listView;
            width: parent.width;
            model: 20;
            delegate: Component {
                Item {
                    id: wrapper;
                    width: parent.width;
                    height: 90;
                    
                    MouseArea {
                        anchors.fill: parent;
                        width: parent.width;
                        onClicked: {
                            listView.currentIndex = index;
                            webTool.currentIdx = index;
                        }
                    }
                    
                    RowLayout {
                        anchors.left: parent.left;
                        anchors.leftMargin: 5;
                        anchors.verticalCenter: parent.verticalCenter;
                        
                        Text {
                            text: webTool.mainInfos[index];
                            width: parent.width;
                            wrapMode: Text.WrapAnywhere;
                            
                            color: listView.currentIndex==index? "red":"black";
                            
                            Layout.preferredWidth: 300;
                        }
                        
                        Text {
                            text: webTool.mainDates[index];
                            width: parent.width;
                            wrapMode: Text.WrapAnywhere;
                            
                            color: listView.currentIndex==index? "red":"black";
                            
                            Layout.preferredWidth: 100;
                        }
                    }

                }
                
            }
            
            focus: true;
            highlight: Rectangle{
                width: parent.width;
                color: "lightblue";
            }
            highlightMoveDuration: 0;
        }
    }
    
    
    
    /*
    ListModel {
         id: mainContent;
         ListElement {
             info: webTool.getMainInfo();
             date: webTool.getMainDate();
             imageUrl: "image";//+index;
             detailUrl: "...";
         }
     }
    
     Component {
         id: mainLayout;
         Item {
             id: wrapper;
             width: parent.width;
             height: 30;
             
             MouseArea {
                 anchors.fill: parent;
                 onClicked: {
                     wrapper.ListView.view.currentIndex = index;
                     webTool.loadMainData();
                     webTool.setIndex(index);
                 }
             }
             
             RowLayout {
                 anchors.left: parent.left;
                 anchors.leftMargin: 5;
                 anchors.verticalCenter: parent.verticalCenter;
                 spacing: 8;
                 
                 Text {
                     text: info;
                     color: wrapper.ListView.isCurrentItem? "red":"black";
                     //font.pixelSize: wrapper.ListView.isCurrentItem? 22:18;
                     Layout.preferredWidth: 120;
                 }
                 
                 Text {
                     text: date;
                     color: wrapper.ListView.isCurrentItem? "red":"black";
                     //font.pixelSize: wrapper.ListView.isCurrentItem? 22:18;
                     Layout.preferredWidth: 80;
                 }
                 
             }
         }
     }
     
     ListView {
         anchors.fill: parent;
         
         model: mainContent;
         delegate: mainLayout;
         
         focus: true;
         highlight: Rectangle{
             color: "lightblue";
         }
         highlightMoveDuration: 0;
     }
     */
}
