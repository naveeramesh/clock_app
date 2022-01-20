import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/models/menu_type.dart';
import 'package:timer_app/providers/countdown.dart';
import 'package:timer_app/providers/firebase.dart';
import 'package:timer_app/providers/timer.dart';
import 'Screen/homeScreen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var initializationSettingsAndroid = AndroidInitializationSettings('clock');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) async {});
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // selectedNotificationPayload = payload;
    // selectNotificationSubject.add(payload);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (b) => MultiProvider(providers: [
                      ChangeNotifierProvider(
                          create: (context) => MenuType(title: "Alarm")),
                      ChangeNotifierProvider(
                          create: (context) => Firebase_App()),
                      ChangeNotifierProvider(create: (context) => StopWatch()),
                      ChangeNotifierProvider(create: (context) => Countdown()),
                    ], child: const HomeScreen()))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Container(
                height: 200,
                child: Lottie.network(
                    "https://assets5.lottiefiles.com/packages/lf20_qgb9xga3.json")),
          ),
          Text(
            "Ready | Set Go",
            style: GoogleFonts.nunitoSans(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            "Set your timer to reach your goal",
            style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 18),
          ),
          Text(
            "Get start quickly",
            style: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
