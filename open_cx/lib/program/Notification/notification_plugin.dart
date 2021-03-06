import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPlugin{
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

    NotificationPlugin(){
      _initializeNotifications();
    }

    void _initializeNotifications(){
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      final initializationSettingsAndroid =AndroidInitializationSettings('app_icon');
      final initializationSettingsIOS = IOSInitializationSettings();
      final initializationSettings = InitializationSettings(
        initializationSettingsAndroid,
        initializationSettingsIOS,
      );
      _flutterLocalNotificationsPlugin.initialize(
          initializationSettings,
        onSelectNotification: onSelectNotification,
      );
    }

    Future onSelectNotification(String payload) async{
      if(payload != null){
        print('otification payload: '+payload);
      }
    }

    Future<void> showWeeklyAtDayTime(Time time,Day day,int id,String title, String description) async{
      final androidPlatformChanelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description',
      );
      final iOSPlatformChannelSpecifics = IOSNotificationDetails();
      final platformChannelSpecifics = NotificationDetails(
        androidPlatformChanelSpecifics,
        iOSPlatformChannelSpecifics,
      );
      await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        id,
        title,
        description,
        day,
        time,
        platformChannelSpecifics,
      );
    }

    Future<void> showDailyAtTime(Time time,int id,String title, String description) async{
      final androidPlatformChanelSpecifics = AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description',
      );
      final iOSPlatformChannelSpecifics = IOSNotificationDetails();
      final platformChannelSpecifics = NotificationDetails(
        androidPlatformChanelSpecifics,
        iOSPlatformChannelSpecifics,
      );
      await _flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        title,
        description,
        time,
        platformChannelSpecifics,
      );
    }

    Future<List<PendingNotificationRequest>> getScheduleNotifications() async{
      final pendingNotifications = await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
      return pendingNotifications;
    }

    Future cancelNotifications(int id) async{
      await _flutterLocalNotificationsPlugin.cancel(id);
    }

  bool checkIfIdExists(List<PendingNotificationRequest> notifications, int id) {
    for (final notification in notifications) {
      if (notification.id == id) {
        return true;
      }
    }
    return false;
  }
}