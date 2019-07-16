#include "WebTool.h"
#include <iostream>
#include <regex>
#include <QFile>

WebTool::WebTool(QObject *parent) : QObject(parent)
{
    
}

void WebTool::loadSiteInfo()
{
    QFile file(":/rcs/siteInfo.txt");
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QByteArray t = file.readAll();
    QString fileContent = QString(t);
    file.close();
    
    QStringList lines = fileContent.split("\n");
    qDebug()<<lines;
    
    for(int i=0;i<lines.length();i++)
    {
        if(lines[i].contains(m_cSite))
        {
            QStringList siteName = lines[i].split(",");
            m_siteName = siteName[2];
            
            QStringList url = lines[i+1].split(",");
            m_siteUrl = url[1];
            
            QStringList info = lines[i+2].split(",");
            m_infoReg.assign(info[1].toStdString());
            
            QStringList date = lines[i+3].split(",");
            m_dateReg.assign(date[1].toStdString());
            
            QStringList detailUrl = lines[i+4].split(",");
            m_detailUrlReg.assign(detailUrl[1].toStdString());
            
            break;
        }
    }
}

void WebTool::getTrueUrlPath(const std::string &siteUrl, const std::string &subUrl, std::string &url)
{
    url = siteUrl.substr(0,siteUrl.find_last_of("/")+1) + subUrl;
    
    QString q_url = url.data();
    QStringList qList_url = q_url.split("/");
    
    for(int i=0;i<qList_url.size();i++)
    {
        //qDebug()<<"qList_url["<<i<<"]:"<<qList_url[i];
        
        if(qList_url[i] == "..")
        {
            qList_url.removeAt(i);
            qList_url.removeAt(i-1);
            
            i -= 2;
        }
    }
        
    q_url = "";
    for(int i=0;i<qList_url.size();i++)
    {
        if(i==qList_url.size()-1)
            q_url += qList_url[i];
        else
            q_url += qList_url[i] + "/";
    }
    
    url = q_url.toStdString();
}

void WebTool::extractWebPageInfo(QString pageCode)
{
    //分行
    QStringList qstrList = pageCode.split("\n");
    
    //去除空格
    for(int i=0;i<qstrList.length();i++)
        qstrList[i] = qstrList[i].simplified();
    
    std::smatch matchResult;
    for(int i=0;i<qstrList.length();i++)
    {
        //正则匹配
        std::string str = qstrList[i].toStdString();
        
        if(std::regex_match(str,matchResult,m_infoReg))
        {
            std::string matchedStr = matchResult[1].str().data();
            QString qstr = QString(matchedStr.data()).simplified();
            m_mainInfos.append(qstr);
        }
        if(std::regex_match(str,matchResult,m_dateReg))
        {
            std::string matchedStr = matchResult[1].str().data();
            QString qstr = QString(matchedStr.data()).simplified();
            m_mainDates.append(qstr);
        }
        if(std::regex_match(str,matchResult,m_detailUrlReg))
        {
            std::string matchedStr = matchResult[1].str().data();
            QString qstr = QString(matchedStr.data()).simplified();
            std::string trueUrl;
            getTrueUrlPath(m_siteUrl.toStdString(),qstr.toStdString(),trueUrl);
            m_mainDetailUrls.append(trueUrl.data());
        }
    }
    
    qDebug()<<"infos:"<<m_mainInfos.length()<<m_mainInfos;
    qDebug()<<"dates:"<<m_mainDates.length()<<m_mainDates;
    qDebug()<<"detailUrls:"<<m_mainDetailUrls.length()<<m_mainDetailUrls;
}

void WebTool::loadMainData()
{
    QUrl url(m_siteUrl);
    QNetworkAccessManager manager;
    QEventLoop loop;
    qDebug() << "Reading code form " << m_siteUrl;
 
    QNetworkReply *reply = manager.get(QNetworkRequest(url));  //发送get请求
    connect(reply,&QNetworkReply::finished,&loop,&QEventLoop::quit); //请求结束并下载完成后，退出子事件循环
 
    //开启子事件循环
    loop.exec();
    
    //得到的网页源码
    QString pageCode = reply->readAll();
    
    //从源码中解析信息
    extractWebPageInfo(pageCode);
}

void WebTool::loadDetailData()
{
    
}

void WebTool::setCSite(QString site)
{
    qDebug()<<"setCSite begin";
    m_cSite = site;
    
    loadSiteInfo();
    
    loadMainData();
    
    qDebug()<<"setCSite end";
}

QString WebTool::getCSiteName() const
{
    return m_siteName;
}

void WebTool::setIndex(int index)
{
    m_currentIdx = index;
}

QStringList WebTool::getMainInfos() const
{
    return m_mainInfos;
}

QStringList WebTool::getMainDates() const
{
    return m_mainDates;
}

/*
QImage WebTool::getMainImage() const
{
    
}
*/

QStringList WebTool::getMainDetailUrls() const
{
    return m_mainDetailUrls;
}

int WebTool::getMainInfoCount() const
{
    return m_mainInfos.size();
}

QString WebTool::getDetailData() const
{
    
    return m_detailData;
}

