import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_app/Screen/clock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime dateTime = DateTime.now();
  var date;
  var day;
  @override
  void initState() {
    setState(() {
      date = DateFormat('hh:mm a').format(DateTime.now()).toString();
      day = DateFormat.yMMMMd().format(DateTime.now()).toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            padding: const EdgeInsets.all(20.0),
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
}
