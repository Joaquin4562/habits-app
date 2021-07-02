import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:habits_app/data/datasource/local_repository_impl.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/domain/repository/api_fcm_interface.dart';

class ApiFCMImplements extends ApiFCMInterface {
  static const PATH = 'https://fcm-backend-habits-app.herokuapp.com';
  @override
  Future<void> scheduleNotification(Habitos habito) async {
    TimeOfDay _time = TimeOfDay(
      hour: int.parse(habito.hora.split(":")[0]),
      minute: int.parse(habito.hora.split(':')[1].split(' ')[0]),
    );
    Dio().post('$PATH/firebase/schedule/notification', data: {
      'registrationToken': await FirebaseMessaging.instance.getToken(),
      'title': habito.categoria,
      'body': 'No te olvides de: ${habito.nombre}',
      'days': habito.dias,
      'hour': _time.hour,
      'minute': _time.minute,
      'uid': await LocalRepositoryImpl().getToken(),
      'habitName': habito.nombre,
    }).then((value) {
      if (!value.data['error']) {
        print(value.data['msg']);
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<void> messagingBackgroundHandle(RemoteMessage message) async {}

  @override
  Future<void> sendNotification(Habitos habito) async {
    TimeOfDay _time = TimeOfDay(
      hour: int.parse(habito.hora.split(":")[0]),
      minute: int.parse(habito.hora.split(':')[1].split(' ')[0]),
    );
    await Dio().post('$PATH/firebase/schedule/notification', data: {
            'registrationToken': await FirebaseMessaging.instance.getToken(),
            'title': habito.categoria,
            'days': habito.dias,
            'hour': _time.hour,
            'minute': _time.minute,
            'body': 'No te olvides de: ${habito.nombre}',
            'uid': await LocalRepositoryImpl().getToken(),
            'habitName': habito.nombre,
          }).then((value) {
            if (!value.data['error']) {
              print(value.data['msg']);
            }
    });
  }
}
