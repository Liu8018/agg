import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import agg.WebTool 1.0

Page {
    visible: true;
    width: initialWidth;
    height: initialHeight;
    title: qsTr("agg");
    
    WebTool {
        id: webTool;
        cSite: "zdh";
    }
    
    ScrollView {
        anchors.fill: parent;
        
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
                            webTool.currentIdx = index;
                        }
                    }
                    
                    RowLayout {
                        id: rowLayout;
                        anchors.left: parent.left;
                        anchors.verticalCenter: parent.verticalCenter;
                        height: parent.height;
                        
                        Rectangle {
                            anchors.fill: parent;
                            color: listView.currentIndex==index? "lightblue":"white";
                        }
                        
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
            
        }
    }
}
