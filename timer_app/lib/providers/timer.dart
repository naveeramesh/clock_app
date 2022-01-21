import 'dart:async';

import 'package:flutter/foundation.dart';

class StopWatch with ChangeNotifier {
  Timer? _timer;
  int _hour = 0;
  int _minute = 0;
  int _seconds = 0;
  bool _startEnable = true;
  bool _stopEnable = false;
  bool _continueEnable = false;

  int get hour => _hour;
  int get minute => _minute;
  int get seconds => _seconds;
  bool get startEnable => _startEnable;
  bool get stopEnable => _stopEnable;
  bool get continueEnable => _continueEnable;

  void startTimer() {
    _hour = 0;
    _minute = 0;
    _seconds = 0;
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }

      notifyListeners();
    });
  }

  void stopTimer() {
    if (_startEnable == false) {
      _startEnable = true;
      _continueEnable = true;
      _stopEnable = false;
      _timer!.cancel();
    }
    notifyListeners();
  }

  void continueTimer() {
    _startEnable = false;
    _stopEnable = true;
    _continueEnable = false;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds < 59) {
        _seconds++;
      } else if (_seconds == 59) {
        _seconds = 0;
        if (_minute == 59) {
          _hour++;
          _minute = 0;
        } else {
          _minute++;
        }
      }

      notifyListeners();
    });
  }

  void reset() {
    _seconds = 0;
    _hour = 0;
    _minute = 0;
    notifyListeners();
  }
}
