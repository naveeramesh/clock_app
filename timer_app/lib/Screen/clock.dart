import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:math';

import 'package:timer_app/widgets/clock_paint.dart';

class CLock extends StatefulWidget {
  const CLock({Key? key}) : super(key: key);

  @override
  _CLockState createState() => _CLockState();
}

class _CLockState extends State<CLock> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 220,
      child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: ClockPainter(),
          )),
    );
  }
}
