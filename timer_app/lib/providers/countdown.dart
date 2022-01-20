import 'package:flutter/cupertino.dart';
import 'dart:async';

class Countdown extends ChangeNotifier {
  int _seconds = 60;
  Timer? _timer;
  int get seconds => _seconds;
  void startcountdown() {
    _seconds = 60;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
      } else {
        print("Done");
      }

      notifyListeners();
    });
  }
}
