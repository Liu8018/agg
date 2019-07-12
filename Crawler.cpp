#include "Crawler.h"
#include <iostream>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QEventLoop>
#include <QObject>
#include <regex>

Crawler::Crawler()
{
    
}

void Crawler::crawl(const std::string &siteUrl, const std::string &domainKeyWord, 
                    const std::vector<std::string> &searchKeywords, 
                    const std::string &dateBegin, const std::string &dateEnd, 
                    std::vector<std::string> &targetUrls,
                    std::vector<std::string> &titles, 
                    std::vector<std::string> &dates, 
                    std::vector<QImage> &imgs)
{
    qDebug()<<"crawl begin";
    
    m_searchKeywords.assign(searchKeywords.begin(),searchKeywords.end());
    m_dateBegin = dateBegin;
    m_dateEnd = dateEnd;
    
    BFS(siteUrl,domainKeyWord,targetUrls);
    
    titles.assign(m_titles.begin(),m_titles.end());
    dates.assign(m_dates.begin(),m_dates.end());
    imgs.assign(m_imgs.begin(),m_imgs.end());
    
    qDebug()<<"crawl end";
}

void Crawler::BFS(std::string siteUrl, std::string domainKeyWord, std::vector<std::string> &urls)
{
    qDebug()<<"BFS begin."<<" url:"<<siteUrl.data();
    
    //获取网页源码
    std::string pageCode;
    getPageCode(siteUrl,pageCode);
    
    //获取网页中的链接
    std::vector<std::string> tmpUrls;
    getUrlsInPage(siteUrl,pageCode,tmpUrls);
    
    //通过域名关键词对链接进行筛选
    for(size_t i=0;i<tmpUrls.size();i++) 
    {
        
    }
    
    //通过散列表不重复地添加链接
    
    
    qDebug()<<"BFS end";
}

void Crawler::getPageCode(std::string siteUrl, std::string &pageCode)
{
    qDebug()<<"getPageCode begin";
    
    QUrl url(siteUrl.data());
    QNetworkAccessManager manager;
    QEventLoop loop;
 
    QNetworkReply *reply = manager.get(QNetworkRequest(url));  //发送get请求
    QObject::connect(reply,&QNetworkReply::finished,&loop,&QEventLoop::quit); //请求结束并下载完成后，退出子事件循环
 
    //开启子事件循环
    loop.exec();
    
    //得到的网页源码
    pageCode.assign(reply->readAll().toStdString());
    
    qDebug()<<"getPageCode end";
}

void Crawler::getUrlsInPage(const std::string &url, const std::string &pageCode, std::vector<std::string> &urls)
{
    qDebug()<<"getUrlsInPage begin";
    
    urls.clear();
    
    std::string pattern("href=\".*\"");
    pattern = "[[:alpha:]]*" + pattern + "[[:alpha:]]*";
    std::regex r(pattern);
    for (std::sregex_iterator it(pageCode.begin(), pageCode.end(), r), end;it != end;++it)        //end是尾后迭代器，regex_iterator是regex_iterator的string类型的版本
    {
        std::string tmpUrl = it->str();
        
        qDebug()<<"v0:"<<tmpUrl.data();
        
        std::smatch matchResult;
        std::regex_match(tmpUrl,matchResult,std::regex("href=\"(.*)\""));
        tmpUrl = matchResult[1].str().data();
        
        qDebug()<<"v1:"<<tmpUrl.data();
        
        if(tmpUrl.substr(0,4) != "http")
        {
            size_t pos = url.find_last_of("/");
            tmpUrl = url.substr(0,pos+1) + tmpUrl;
        }
        
        qDebug()<<"v2:"<<tmpUrl.data();
        urls.push_back(tmpUrl);
    }
    
    qDebug()<<"getUrlsInPage end";
}
