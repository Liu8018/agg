#include <QtCore/QUrl>
#include <QtCore/QCommandLineOption>
#include <QtCore/QCommandLineParser>
#include <QGuiApplication>
#include <QStyleHints>
#include <QScreen>
#include <QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtWebView/QtWebView>

#include "WebTool.h"
#include "NotificationClient.h"

class Utils : public QObject {
    Q_OBJECT
public:
    Utils(QObject* parent = nullptr) : QObject(parent) { }
    Q_INVOKABLE static QUrl fromUserInput(const QString& userInput);
};

QUrl Utils::fromUserInput(const QString& userInput)
{
    if (userInput.isEmpty())
        return QUrl::fromUserInput("about:blank");
    const QUrl result = QUrl::fromUserInput(userInput);
    return result.isValid() ? result : QUrl::fromUserInput("about:blank");
}

#include "main.moc"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtWebView::initialize();
    
    QGuiApplication::setApplicationDisplayName(QCoreApplication::translate("main","agg"));
    QCommandLineParser parser;
    QCoreApplication::setApplicationVersion(QT_VERSION_STR);
    parser.setApplicationDescription(QGuiApplication::applicationDisplayName());
    parser.addHelpOption();
    parser.addVersionOption();
    parser.addPositionalArgument("url", "The initial URL to open.");
    QStringList arguments = app.arguments();
    parser.process(arguments);

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    context->setContextProperty(QStringLiteral("utils"), new Utils(&engine));
    
    //注册WebTool类
    WebTool *webTool = new WebTool(&engine);
    context->setContextProperty(QLatin1String("webTool"),webTool);
    //注册NotificationClient类
    NotificationClient *notificationClient = new NotificationClient(&engine);
    context->setContextProperty(QLatin1String("notificationClient"),notificationClient);
    
    //获取屏幕尺寸信息
    QRect geometry = QGuiApplication::primaryScreen()->availableGeometry();
    if (!QGuiApplication::styleHints()->showIsFullScreen()) {
        const QSize size = geometry.size() * 4 / 5;
        const QSize offset = (geometry.size() - size) / 2;
        const QPoint pos = geometry.topLeft() + QPoint(offset.width(), offset.height());
        geometry = QRect(pos, size);
    }
    context->setContextProperty(QStringLiteral("initialX"), geometry.x());
    context->setContextProperty(QStringLiteral("initialY"), geometry.y());
    context->setContextProperty(QStringLiteral("initialWidth"), geometry.width());
    context->setContextProperty(QStringLiteral("initialHeight"), geometry.height());

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
