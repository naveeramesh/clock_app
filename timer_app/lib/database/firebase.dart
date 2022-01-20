import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timer_app/models/alarm.dart';

import '../main.dart';

class Firebase_App extends ChangeNotifier {
  adddata(Alarm alarm) async {
    FirebaseFirestore.instance
        .collection("Alarms")
        .doc(alarm.id.toString())
        .set({
      "id": alarm.id,
      "title": alarm.title,
      "description": alarm.description,
      "alarm_time": alarm.datatime,
      "active": alarm.isactive,
    }).whenComplete(() async {
      var scheduledtime = alarm.datatime;
      var endtime = alarm.datatime.add(Duration(minutes: 1));
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Alarm',
        'Knock - Knock Alarm',
        channelDescription: 'Setted up for alamr notification',
        icon: 'clock',
        largeIcon: const DrawableResourceAndroidBitmap('clock'),
      );

      var platformChannelSpecifies = NotificationDetails(
          android: androidPlatformChannelSpecifics, iOS: null);
      await flutterLocalNotificationsPlugin
          .schedule(
        alarm.id,
        alarm.title,
        alarm.description,
        scheduledtime,
        platformChannelSpecifies,
      )
          .whenComplete(() {
        Timer.periodic(Duration(seconds: 1), (timer) {
          final currentTime = DateTime.now();
          if (currentTime.isAfter(scheduledtime.add(Duration(seconds: 4))) &&
              currentTime.isBefore(endtime)) {
            print("Hello World");
            FirebaseFirestore.instance
                .collection("Alarms")
                .doc(alarm.id.toString())
                .update({
              "active": 0,
            });
          }
        });
      });
    });
    notifyListeners();
  }

  deletedata(int id) async {
    FirebaseFirestore.instance
        .collection("Alarms")
        .doc(id.toString())
        .delete()
        .whenComplete(() async {
      await flutterLocalNotificationsPlugin.cancel(id);
      print("Cancelled");
    });

    notifyListeners();
  }


}
