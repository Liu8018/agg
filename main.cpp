#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtCore/QUrl>
#include <QtCore/QCommandLineOption>
#include <QtCore/QCommandLineParser>
#include <QGuiApplication>
#include <QStyleHints>
#include <QScreen>
#include <QtQml/QQmlContext>
#include <QtWebView/QtWebView>
#include "WebTool.h"

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
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    
    QGuiApplication app(argc, argv);
    
    //注册WebTool类
    qmlRegisterType<WebTool>("agg.WebTool",1,0,"WebTool");
    
    //启动WebView
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
    const QString initialUrl = parser.positionalArguments().isEmpty() ?
        QStringLiteral("https://www.baidu.com") : parser.positionalArguments().first();
    
    //启动qml engine
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    
    /*
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    */
    
    //字体、分辨率、界面大小设置
    QQmlContext *context = engine.rootContext();
    context->setContextProperty(QStringLiteral("utils"), new Utils(&engine));
    context->setContextProperty(QStringLiteral("initialUrl"),
                                Utils::fromUserInput(initialUrl));
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
    
    //加载main.qml
    engine.load(url);
    if (engine.rootObjects().isEmpty())
        return -1;
    
    return app.exec();
}
