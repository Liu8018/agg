#ifndef CRAWLER_H
#define CRAWLER_H

#include <vector>
#include <QImage>

class Crawler
{
public:
    Crawler();
    
    void crawl(const std::string &siteUrl, const std::string &domainKeyWord,
               const std::vector<std::string> &searchKeywords,
               const std::string &dateBegin, const std::string &dateEnd,
               std::vector<std::string> &targetUrls,
               std::vector<std::string> &titles,
               std::vector<std::string> &dates,
               std::vector<QImage> &imgs);
    
private:
    /*
    std::vector<std::string> m_urls;
    std::vector<std::string> m_dates;
    std::vector<std::string> m_mainCpns;
    std::vector<QImage> m_imgs;
    */
    
    //搜索条件
    std::vector<std::string> m_searchKeywords;
    std::string m_dateBegin;
    std::string m_dateEnd;
    
    //保存访问过的链接，防止重复
    std::map<std::string,bool> m_visitedUrls;
    
    //符合条件的链接
    std::vector<std::string> m_targetUrls;
    //链接对应的信息
    std::vector<std::string> m_titles;
    std::vector<std::string> m_dates;
    std::vector<QImage> m_imgs;
    
    
    //获取网页源码
    void getPageCode(std::string siteUrl, std::string &pageCode);
    //获取网页源码中的链接
    void getUrlsInPage(const std::string &url, const std::string &pageCode, std::vector<std::string> &urls);
    //广度优先搜索，遍历整个网络
    void BFS(std::string siteUrl, std::string domainKeyWord, std::vector<std::string> &urls);
};

#endif // CRAWLER_H
