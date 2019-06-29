#include "WebTool.h"
#include <regex>

WebTool::WebTool(QObject *parent) : QObject(parent)
{
    
}

void WebTool::extractInfo(QString pageCode)
{
    //分行
    QStringList qstrList = pageCode.split("\n");
    
    //去除空格
    for(int i=0;i<qstrList.length();i++)
        qstrList[i] = qstrList[i].simplified();
    
    std::regex reg("<span>(.*)</span>");
    std::smatch matchResult;
    for(int i=0;i<qstrList.length();i++)
    {
        if(qstrList[i].contains("crules_con"))
        {
            int offset = 3;
            
            //正则匹配
            std::string str = qstrList[i+offset].toStdString();
            
            if(std::regex_match(str,matchResult,reg))
            {
                qDebug()<<matchResult[1].str().data();
            }
        }
    }
}

void WebTool::loadMainData()
{
    QUrl url(m_mainUrl);
    QNetworkAccessManager manager;
    QEventLoop loop;
    qDebug() << "Reading code form " << m_mainUrl;
 
    QNetworkReply *reply = manager.get(QNetworkRequest(url));  //发送get请求
    connect(reply,&QNetworkReply::finished,&loop,&QEventLoop::quit); //请求结束并下载完成后，退出子事件循环
 
    //开启子事件循环
    loop.exec();
    
    //得到的网页源码
    QString pageCode = reply->readAll();
    
    //从源码中解析信息
    extractInfo(pageCode);
}

void WebTool::loadDetailData()
{
    
}

void WebTool::setMainUrl(QString url)
{
    m_mainUrl = url;
}

void WebTool::setIndex(uint index)
{
    m_currentIdx = index;
}

QString WebTool::getMainInfo() const
{
    
}
QString WebTool::getMainDate() const
{
    
}
QImage WebTool::getMainImage() const
{
    
}
QString WebTool::getMainDetailUrl() const
{
    
}

QString WebTool::getDetailData() const
{
    
    return m_detailData;
}

