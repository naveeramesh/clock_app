import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timer_app/models/alarm.dart';

import '../main.dart';

class MenuType extends ChangeNotifier {
  String? title;
  Icon? icon;
  Color? color;
  MenuType({this.title, this.icon, this.color});

  update_fn(MenuType menuType) {
    this.title = menuType.title;
    this.icon = menuType.icon;
    this.color = menuType.color;
    print(title);
    print(icon);
    notifyListeners();
  }
   void notification() async {
    var scheduledtime = DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Alarm',
      'Knock - Knock Alarm',
      channelDescription: 'Setted up for alamr notification',
      icon: 'clock',
      largeIcon: const DrawableResourceAndroidBitmap('clock'),
    );

    var platformChannelSpecifies = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        "Office",
        "Good morning!It's time to wake up",
        scheduledtime,
        platformChannelSpecifies);

        
  }
}

List<MenuType> items = [
  MenuType(title: "Alarm", icon: Icon(Icons.alarm), color: Colors.amber),
  MenuType(title: "Timer", icon: Icon(Icons.timelapse), color: Colors.blue),
  MenuType(title: "Watch", icon: Icon(Icons.lock_clock), color: Colors.red)
];

