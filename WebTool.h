#ifndef WEBTOOL_H
#define WEBTOOL_H

#include <QObject>
#include <QImage>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QEventLoop>
#include <QFile>
#include <regex>

class WebTool : public QObject
{
    Q_OBJECT
    
    Q_PROPERTY(QString cSite WRITE setCSite)
    
    Q_PROPERTY(int currentIdx WRITE setIndex)
    
    Q_PROPERTY(QStringList mainInfos READ getMainInfos NOTIFY mainInfosChanged)
    Q_PROPERTY(QStringList mainDates READ getMainDates NOTIFY mainDatesChanged)
    //Q_PROPERTY(QImage getMainImage READ getMainImage)
    Q_PROPERTY(QStringList mainDetailUrls READ getMainDetailUrls NOTIFY mainDetailUrlsChanged)
    
    Q_PROPERTY(int mainInfoCount READ getMainInfoCount)
    
    Q_PROPERTY(QString detailData READ getDetailData)
    
public:
    WebTool(QObject *parent = nullptr);
    
    Q_INVOKABLE void loadMainData();
    Q_INVOKABLE void loadDetailData();
    
    void setCSite(QString site);
    
    void setIndex(int index);
    
    QStringList getMainInfos() const;
    QStringList getMainDates() const;
    //QImage getMainImage() const;
    QStringList getMainDetailUrls() const;
    
    int getMainInfoCount() const;
    
    QString getDetailData() const;
    
signals:
    void mainInfosChanged(QStringList mainInfos);
    void mainDatesChanged(QStringList mainDates);
    void mainDetailUrlsChanged(QStringList mainDetailUrls);
    
public slots:
    
private:
    QString m_cSite;
    int m_currentIdx;
    
    QStringList m_mainInfos;
    QStringList m_mainDates;
    QStringList m_mainImages;
    QStringList m_mainDetailUrls;
    
    QString m_detailData;
    
    QString m_siteName;
    QString m_siteUrl;
    
    std::regex m_infoReg;
    std::regex m_dateReg;
    std::regex m_detailUrlReg;
    
    void loadSiteInfo();
    
    void extractWebPageInfo(QString pageCode);
    
    void getTrueUrlPath(const std::string &siteUrl, const std::string &subUrl, std::string &url);
};

#endif // WEBTOOL_H
