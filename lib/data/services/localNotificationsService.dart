import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationsService {
  final flutterlocalNotificaionsPlugin = FlutterLocalNotificationsPlugin();
  static final LocalNotificationsService _notificationsService =
      LocalNotificationsService._internal();
  factory LocalNotificationsService() {
    return _notificationsService;
  }
  static const _chanelID = 'habits';
  LocalNotificationsService._internal();
  Future<void> initSerivce() async {
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
    await flutterlocalNotificaionsPlugin.cancelAll();
  }

  void cancelNotificationHabit(int id) async {
    await flutterlocalNotificaionsPlugin.cancel(id);
  }

  void showNotification(RemoteMessage message) async {
    RemoteNotification notification = message.notification!;
    await flutterlocalNotificaionsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'chanel id',
          'chanel name',
          'channel Description',
        ),
      ),
    );
  }
}
