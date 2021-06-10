import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:habits_app/domain/models/habits.model.dart';

abstract class ApiFCMInterface {
  Future<void> scheduleNotification(Habitos habito);
  Future<void> messagingBackgroundHandle(RemoteMessage message);
  Future<void> sendNotification(Habitos habito);
}