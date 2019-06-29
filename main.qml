import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import agg.WebTool 1.0

ApplicationWindow {
    visible: true;
    width: initialWidth;
    height: initialHeight;
    title: qsTr("agg");
    
    /*
    ScrollView {
        anchors.fill: parent
        
        ListView {
            width: parent.width
            model: 20
            delegate: ItemDelegate {
                text: "Item " + (index + 1)
                width: parent.width
            }
        }
    }
    */
    
    WebTool {
        id: webTool;
        mainUrl: "http://jwc.bit.edu.cn/tzgg/index.htm";
    }
    
    ListModel {
         id: mainContent;
         ListElement {
             info: "info";//+index;
             date: "date";//+index;
             imageUrl: "image";//+index;
             detailUrl: "...";
         }
         ListElement {
             info: "info1";//+index;
             date: "date1";//+index;
             imageUrl: "image1";//+index;
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
}
