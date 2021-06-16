import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationsService {

  static final LocalNotificationsService _notificationsService =
      LocalNotificationsService._internal();
  factory LocalNotificationsService() {
    return _notificationsService;
  }
  LocalNotificationsService._internal();
  Future<void> initSerivce() async {
      final FlutterLocalNotificationsPlugin flutterlocalNotificaionsPlugin =
      FlutterLocalNotificationsPlugin();
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null,
      macOS: null,
    );
    await flutterlocalNotificaionsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    tz.initializeTimeZones();
  }

  Future selectNotification(String? payload) async {}
  void cancelAllNotifications() async {
      final FlutterLocalNotificationsPlugin flutterlocalNotificaionsPlugin =
      FlutterLocalNotificationsPlugin();
    await flutterlocalNotificaionsPlugin.cancelAll();
  }

  void cancelNotificationHabit(int id) async {
      final FlutterLocalNotificationsPlugin flutterlocalNotificaionsPlugin =
      FlutterLocalNotificationsPlugin();
    await flutterlocalNotificaionsPlugin.cancel(id);
  }

  void showNotification(RemoteMessage message) async {
      final FlutterLocalNotificationsPlugin flutterlocalNotificaionsPlugin =
      FlutterLocalNotificationsPlugin();
    RemoteNotification notification = message.notification!;
    await flutterlocalNotificaionsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          '1231',
          'Habits chanel',
          'Chanel to habits notifications',
          icon: 'app_icon',
        ),
      ),
    );
  }
}
