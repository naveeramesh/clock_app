import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/Screen/clock.dart';
import 'package:timer_app/providers/service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime dateTime = DateTime.now();
  var date = DateFormat('hh:mm a').format(DateTime.now()).toString();
  var day = DateFormat.yMMMd().format(DateTime.now()).toString();
  @override
  void initState() {
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        date = DateFormat('hh:mm a').format(DateTime.now()).toString();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Clock",
          style: GoogleFonts.nunitoSans(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row_Container(Icon(Icons.alarm), "Alarm", Colors.amber),
                Row_Container(Icon(Icons.timelapse), "Timer", Colors.blue),
                Row_Container(Icon(Icons.lock_clock), "Watch", Colors.red)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 20),
            child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: CLock()),
          ),
          Text(
            date,
            style: GoogleFonts.nunitoSans(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text(
            day,
            style: GoogleFonts.nunitoSans(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Row_Container(Icon icon, String text, Color iconcolor) {
    Service service = Provider.of<Service>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: GestureDetector(
        onTap: () {
          print(service.color);
          text == "Alarm" ? service.color = Colors.red : null;
        },
        child: Container(
          height: 50,
          width: 115,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: service.color),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(icon.icon, color: iconcolor),
              SizedBox(
                width: 5,
              ),
              Text(
                text.toString(),
                style: GoogleFonts.nunitoSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
