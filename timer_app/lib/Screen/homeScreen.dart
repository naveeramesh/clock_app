import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/Screen/clock.dart';
import 'package:timer_app/models/alarm.dart';
import 'package:timer_app/models/menu_type.dart';
import 'package:timer_app/providers/countdown.dart';
import 'package:timer_app/providers/firebase.dart';
import 'package:timer_app/providers/timer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();

  String currenttime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  var date = DateFormat('hh:mm a').format(DateTime.now()).toString();
  var day = DateFormat.yMMMd().format(DateTime.now()).toString();

  @override
  void initState() {
    Timer.periodic(Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          date = DateFormat('hh:mm a').format(DateTime.now()).toString();
         });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Firebase_App firebase_app = Provider.of<Firebase_App>(context);
    return Scaffold(
      floatingActionButton: Consumer<MenuType>(
        builder: (context, value, child) => value.title == "Alarm"
            ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    TimeOfDay? newTime = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (newTime != null) {
                                      var now = DateTime.now();
                                      var newdateTime = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        newTime.hour,
                                        newTime.minute,
                                      );
                                      if (mounted) {
                                        setState(() {
                                          currenttime = newdateTime.toString();
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                      height: 60,
                                      child: Center(
                                          child: Text(
                                        currenttime,
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ))),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30),
                                  child: TextField(
                                    controller: titlecontroller,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      hintText: "Title",
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, right: 30),
                                  child: TextField(
                                    controller: descontroller,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      hintText: "Description",
                                      hintStyle: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 18),
                                    ),
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  var respectsQuery = FirebaseFirestore.instance
                                      .collection('Alarms');
                                  var querySnapshot = await respectsQuery.get();
                                  var totalEquals = querySnapshot.docs.length;

                                  var alarm = Alarm(
                                      id: totalEquals++,
                                      isactive: 1,
                                      title: titlecontroller.text.toString(),
                                      description:
                                          descontroller.text.toString(),
                                      datatime: DateTime.parse(currenttime));
                                  firebase_app.adddata(alarm);
                                  titlecontroller.clear();
                                  descontroller.clear();

                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Colors.pink, Colors.purple]),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "Set Alarm",
                                      style: GoogleFonts.nunitoSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.add),
              )
            : SizedBox(),
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
                child: Consumer<MenuType>(
                    builder: (context, value, child) => value.title == "Alarm"
                        ? Column(
                            children: [
                              CLock(),
                              SizedBox(height: 20),
                              Text(
                                date,
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              Text(
                                day,
                                style: GoogleFonts.nunitoSans(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          )
                        : SizedBox())),
          ),
          Consumer<MenuType>(
            builder: (context, value, child) => value.title == "Alarm"
                ? Expanded(
                    child: Container(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("Alarms")
                                .where("active", isEqualTo: 1)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Timestamp timestamp = snapshot.data!
                                        .docs[index]['alarm_time'] as Timestamp;
                                    final DateTime dateTime =
                                        timestamp.toDate();
                                    final dateString =
                                        DateFormat('hh:mm a').format(dateTime);
                                    final dayString =
                                        DateFormat.yMMMd().format(dateTime);
                                    // final day = DateFormat.yMMMd(dateTime);
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30.0, right: 30, top: 30),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(colors: [
                                              Colors.pink,
                                              Colors.purple
                                            ])),
                                        width: double.infinity,
                                        height: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Icon(Icons.alarm,
                                                  color: Colors.white,
                                                  size: 20),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(day,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(dateString,
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ],
                                              ),
                                              Spacer(),
                                              IconButton(
                                                  onPressed: () {
                                                    firebase_app.deletedata(
                                                        snapshot.data!
                                                            .docs[index]['id']);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            })))
                : SizedBox(),
          ),
          Consumer<MenuType>(
              builder: (context, value, child) => value.title == "Timer"
                  ? Expanded(child: Container(child: buildTimer()))
                  : SizedBox()),
          Consumer<MenuType>(
              builder: (context, value, child) => value.title == "Watch"
                  ? Expanded(child: Container(child: buildbutton()))
                  : SizedBox()),
        ],
      ),
    );
  }

  Widget buildTimer() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "HH",
                  style: GoogleFonts.nunitoSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Consumer<Countdown>(
                builder: (context, value, child) => NumberPicker(
                    textStyle: GoogleFonts.nunitoSans(color: Colors.white),
                    selectedTextStyle: GoogleFonts.nunitoSans(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    value: value.hour,
                    minValue: 0,
                    maxValue: 23,
                    onChanged: (val) {
                      value.sethour(val);
                      value.startcountdown();
                    }),
              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "MM",
                  style: GoogleFonts.nunitoSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Consumer<Countdown>(
                builder: (context, value, child) => NumberPicker(
                    textStyle: GoogleFonts.nunitoSans(color: Colors.white),
                    selectedTextStyle: GoogleFonts.nunitoSans(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    value: value.min,
                    minValue: 0,
                    maxValue: 60,
                    onChanged: (val) {
                      value.setmin(val);
                      value.startcountdown();
                    }),
              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "SS",
                  style: GoogleFonts.nunitoSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Consumer<Countdown>(
                builder: (context, value, child) => NumberPicker(
                    textStyle: GoogleFonts.nunitoSans(color: Colors.white),
                    selectedTextStyle: GoogleFonts.nunitoSans(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    value: value.seconds,
                    minValue: 0,
                    maxValue: 60,
                    onChanged: (val) {
                      value.setsec(val);
                      value.startcountdown();
                    }),
              )
            ],
          )
        ],
      ),
      SizedBox(
        height: 50,
      ),
      Consumer<Countdown>(
        builder: (context, value, child) => CircleAvatar(
            backgroundColor: Colors.green,
            radius: 90,
            child: CircleAvatar(
              radius: 85,
              backgroundColor: Colors.black,
              child: Text(
                "${value.totalsec}",
                style: GoogleFonts.nunitoSans(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ),
      Spacer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              final countdown = Provider.of<Countdown>(context, listen: false);
              countdown.settimer();
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [Colors.blue[600]!, Colors.white12],
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.play_arrow, color: Colors.white),
                )),
          ),
          SizedBox(width: 20),
          Consumer<Countdown>(
            builder: (context, value, child) => GestureDetector(
              onTap: () {
                value.stoptimer();
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Colors.blue[600]!, Colors.white12],
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.stop, color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
    ]);
  }

  Widget buildbutton() {
    return Column(
      children: [
        Container(
          child: Consumer<StopWatch>(
            builder: (context, timer, child) => CircleAvatar(
              radius: 120,
              backgroundColor: Colors.green,
              child: CircleAvatar(
                radius: 115,
                backgroundColor: Colors.black,
                child: Text(
                  "${timer.hour} : ${timer.minute} : ${timer.seconds} ",
                  style: GoogleFonts.nunitoSans(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                final settimer = Provider.of<StopWatch>(context, listen: false);
                settimer.startTimer();
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Colors.blue[600]!, Colors.white12],
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.play_arrow, color: Colors.white),
                  )),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                final settimer = Provider.of<StopWatch>(context, listen: false);
                settimer.stopTimer();
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Colors.blue[600]!, Colors.white12],
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.stop, color: Colors.white),
                  )),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                final settimer = Provider.of<StopWatch>(context, listen: false);
                settimer.reset();
              },
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Colors.blue[600]!, Colors.white12],
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.refresh, color: Colors.white),
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            final settimer = Provider.of<StopWatch>(context, listen: false);
            settimer.continueTimer();
          },
          child: Container(
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.blue[600]!, Colors.white12],
                  )),
              child: Center(
                  child: Text(
                "Continue",
                style: GoogleFonts.nunitoSans(color: Colors.white),
              ))),
        ),
        SizedBox(
          height: 30,
        ),
      ],
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
