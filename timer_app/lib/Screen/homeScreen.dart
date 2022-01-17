import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:timer_app/widgets/clock_paint.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              child: CLock()),
        ],
      ),
    );
  }
}

class CLock extends StatefulWidget {
  const CLock({Key? key}) : super(key: key);

  @override
  _CLockState createState() => _CLockState();
}

class _CLockState extends State<CLock> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(painter:ClockPainter(),)
      ),
    );
  }
}


