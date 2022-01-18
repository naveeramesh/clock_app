import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/Screen/clock.dart';
import 'package:timer_app/models/alarm.dart';
import 'package:timer_app/models/menu_type.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
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
                children: items
                    .map((currentmenutype) => Row_Container(currentmenutype))
                    .toList()),
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
          SizedBox(
            height: 20,
          ),
          Consumer<MenuType>(
              builder: (_, value, __) => value.title == "Alarm"
                  ? Expanded(
                      child: ListView(
                          children: alarm_items.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 30, right: 30, bottom: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.red.withOpacity(0.5),
                                    blurRadius: 5,
                                    spreadRadius: 2)
                              ],
                              gradient: LinearGradient(
                                  colors: [Colors.pink, Colors.purple]),
                              // gradient: LinearGradient(colors: e.color),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.label,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      e.description.toString(),
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Spacer(),
                                    Switch(
                                        activeColor: Colors.white,
                                        value: e.isset!,
                                        onChanged: (bool value) {})
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    e.day.toString(),
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, bottom: 10),
                                  child: Text(
                                    "10:00 AM",
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList()),
                    )
                  : SizedBox())
        ],
      ),
    );
  }

  Widget Row_Container(MenuType currentmenutype) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Consumer<MenuType>(
        builder: (_, value, __) => GestureDetector(
          onTap: () {
            var final_menu = Provider.of<MenuType>(context, listen: false);
            final_menu.update_fn(currentmenutype);
          },
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentmenutype.title == value.title
                    ? Colors.grey[900]!
                    : Colors.transparent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(currentmenutype.icon?.icon, color: currentmenutype.color),
                SizedBox(
                  width: 5,
                ),
                Text(
                  currentmenutype.title.toString(),
                  style: GoogleFonts.nunitoSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
