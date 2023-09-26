// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:push_notification/firebase_service/local_notifiaction_service.dart';

// class FirebaseService {
//   void getNotification() async {
//     // method call when app closed (terminated state)
//     // when you click no notification app will open
//     FirebaseMessaging.instance.getInitialMessage().then(
//       (message) {
//         print("FirebaseMessaging.instance.getInitialMessage");
//         if (message != null) {
//           print("New Notification");
//           LocalNotificationService.createanddisplaynotification(message);
//           // if (message.data['_id'] != null) {
//           //   Navigator.of(context).push(
//           //     MaterialPageRoute(
//           //       builder: (context) => SecondPage(
//           //         id: message.data['_id'],
//           //       ),
//           //     ),
//           //   );
//           // }
//         }
//       },
//     );

//     // This method only call when App in running state. (app must be open)
//     FirebaseMessaging.onMessage.listen(
//       (message) {
//         print("FirebaseMessaging.onMessage.listen");
//         if (message.notification != null) {
//           print(message.notification!.title);
//           print(message.notification!.body);
//           print("message.data11 ${message.data}");
//           LocalNotificationService.createanddisplaynotification(message);
//         }
//       },
//     );

//     //This method only call when App in background and not terminated(not closed)
//     FirebaseMessaging.onMessageOpenedApp.listen(
//       (message) {
//         print("FirebaseMessaging.onMessageOpenedApp.listen");
//         if (message.notification != null) {
//           print("Background notification title" +
//               message.notification!.title.toString());
//           print("Background notification body" +
//               message.notification!.body.toString());
//           print("message.data22 ${message.data['_id']}");
//           LocalNotificationService.createanddisplaynotification(message);
//         }
//       },
//     );
//   }

//   Future<void> getPermission() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;

//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//     final FCMToken = await messaging.getToken();
//     print('fcm token = $FCMToken');
//   }
// }
