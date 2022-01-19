import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/Screen/clock.dart';
import 'package:timer_app/database/db_helper.dart';
import 'package:timer_app/database/firebase.dart';
import 'package:timer_app/models/alarm.dart';
import 'package:timer_app/models/menu_type.dart';

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
      setState(() {
        date = DateFormat('hh:mm a').format(DateTime.now()).toString();
        currenttime;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Firebase_App firebase_app = Provider.of<Firebase_App>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // final setalarm = Provider.of<MenuType>(context, listen: false);
          // setalarm.notification();
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            builder: (context) {
              return Container(
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
                            setState(() {
                              currenttime = newdateTime.toString();
                            });
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
                        padding: const EdgeInsets.only(left: 30.0, right: 30),
                        child: TextField(
                          controller: titlecontroller,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
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
                        padding: const EdgeInsets.only(left: 30.0, right: 30),
                        child: TextField(
                          controller: descontroller,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent)),
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
                      onTap: () {
                        var alarm = Alarm(
                            
                            isactive: 1,
                            title: titlecontroller.text.toString(),
                            description: descontroller.text.toString(),
                            datatime: DateTime.parse(currenttime));
                        firebase_app.adddata(alarm);
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
              );
            },
          );
        },
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
            builder: (context, value, child) =>
                value.title == "Alarm" ? Container() : SizedBox(),
          ),
          Expanded(
              child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Alarms")
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
                              return Container(
                                width: double.infinity,
                                height: 100,
                                color: Colors.red,
                                child:
                                    Text(snapshot.data!.docs[index]['title']),
                              );
                            },
                          );
                        }
                      })))
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
