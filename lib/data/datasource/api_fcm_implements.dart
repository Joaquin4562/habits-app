import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:habits_app/domain/models/habits.model.dart';
import 'package:habits_app/domain/repository/api_fcm_interface.dart';

class ApiFCMImplements extends ApiFCMInterface {
  @override
  Future<void> scheduleNotification(Habitos habito) async {
    TimeOfDay _time = TimeOfDay(
      hour: int.parse(habito.hora.split(":")[0]),
      minute: int.parse(habito.hora.split(':')[1].split(' ')[0]),
    );
    await Dio().post('path', data: {
      'registrationToken': FirebaseMessaging.instance.getToken(),
      'title': habito.categoria,
      'body': habito.nombre,
      'days': habito.dias,
      'hour': _time.hour,
      'minute': _time.minute,
    }).then((value) {
      if(!value.data['error']) {
        print(value.data['msg']);
      }
    });
  }

  @override
  Future<void> messagingBackgroundHandle(RemoteMessage message) async {}

  @override
  Future<void> sendNotification(Habitos habito) async {
    await Dio().post('path', data: {
      'registrationToken': FirebaseMessaging.instance.getToken(),
      'title': habito.categoria,
      'body': habito.nombre,
    }).then((value) {
      if(!value.data['error']) {
        print(value.data['msg']);
      }
    });
  }
}
