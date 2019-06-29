#ifndef WEBTOOL_H
#define WEBTOOL_H

#include <QObject>
#include <QImage>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QEventLoop>

class WebTool : public QObject
{
    Q_OBJECT
    
    Q_PROPERTY(QString mainUrl WRITE setMainUrl)
    
    Q_PROPERTY(uint currentIdx WRITE setIndex)
    
    Q_PROPERTY(QString mainInfo READ getMainInfo)
    Q_PROPERTY(QString mainDate READ getMainDate)
    Q_PROPERTY(QImage getMainImage READ getMainImage)
    Q_PROPERTY(QString getMainDetailUrl READ getMainDetailUrl)
    
    Q_PROPERTY(QString detailData READ getDetailData)
    
public:
    WebTool(QObject *parent = nullptr);
    
    Q_INVOKABLE void loadMainData();
    Q_INVOKABLE void loadDetailData();
    
    void setMainUrl(QString url);
    
    void setIndex(uint index);
    
    QString getMainInfo() const;
    QString getMainDate() const;
    QImage getMainImage() const;
    QString getMainDetailUrl() const;
    
    QString getDetailData() const;
    
signals:
    
public slots:
    
private:
    QString m_mainUrl;
    uint m_currentIdx;
    
    std::vector<QString> m_mainData;
    QString m_detailData;
    
    void extractInfo(QString pageCode);
};

#endif // WEBTOOL_H
