import 'package:flutter/cupertino.dart';
import 'dart:async';

class Countdown extends ChangeNotifier {
  int _seconds = 0;
  int _hour = 0;
  int _min = 0;

  int totalsec = 0;
  Timer? _timer;
  int get seconds => _seconds;
  int get hour => _hour;
  int get min => _min;

  void setsec(int value) {
    _seconds = value;

    notifyListeners();
  }

  void sethour(int value) {
    _hour = value;

    notifyListeners();
  }

  void setmin(int value) {
    _min = value;

    notifyListeners();
  }

  void startcountdown() {
    int tototalmin = _min * 60;
    int totalhour = _hour * 60 * 60;
    totalsec = totalhour + tototalmin + _seconds;
    notifyListeners();
  }
  // void startcountdown() {
  //   _seconds = 60;

  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (_seconds > 0) {
  //       _seconds--;
  //     } else {
  //       print("Done");
  //     }

  //     notifyListeners();
  //   });
}
