import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:timer_app/models/alarm.dart';

class Firebase_App extends ChangeNotifier {
  adddata(Alarm alarm) async {
    FirebaseFirestore.instance.collection("Alarms").doc(alarm.title).set({
      "id": alarm.id,
      "title": alarm.title,
      "description": alarm.description,
      "alarm_time": alarm.datatime,
      "active": alarm.isactive,
    });
    notifyListeners();
  }
}
