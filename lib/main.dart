import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:push_notification/notification_service/notifocation_service.dart';
import 'package:push_notification/view/home_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // this data came from backend (postman)
  String datetimeStr = message.data['timeStamp'];
  final format = DateFormat("dd/MM/yyyy, HH:mm:ss");
  DateTime datetime = format.parse(datetimeStr);

  NotificationServices().scheduleNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      scheduledNotificationDateTime: datetime);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
