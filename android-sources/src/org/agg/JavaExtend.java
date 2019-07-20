package org.agg;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;

public class JavaExtend extends org.qtproject.qt5.android.bindings.QtActivity
{
    private static NotificationManager m_notificationManager;
    private static Notification.Builder m_builder;
    private static JavaExtend m_instance;

    public JavaExtend()
    {
        m_instance = this;
    }

    public static void notify(String s)
    {
        if (m_notificationManager == null) {
            m_notificationManager = (NotificationManager)m_instance.getSystemService(Context.NOTIFICATION_SERVICE);
            m_builder = new Notification.Builder(m_instance);
            m_builder.setSmallIcon(R.drawable.icon);
            m_builder.setContentTitle("A message from Agg!");
        }

        m_builder.setContentText(s);
        m_notificationManager.notify(1, m_builder.build());
    }
    
    //----------------------------------------------------------------------------------------------
    
    public void parseHtml(String s)
    {
        HtmlParser parser = new HtmlParser();
        parser.test(s);
    }
}

class HtmlParser
{
    public void test(String s)
    {
        System.out.println(s);
    }
}

