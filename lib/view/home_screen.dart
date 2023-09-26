import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:push_notification/notification_service/notifocation_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NotificationServices notificationServices = NotificationServices();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    // notificationServices.scheduleNotificationInTimeZone();

    notificationServices.getDeviceToken().then((value){
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notifications'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: (){

              // send notification from one device to another
              notificationServices.getDeviceToken().then((value)async{

                var data = {
                  'to' : value.toString(),
                  'notification' : {
                    'title' : 'Testing Notifiaction' ,
                    'body' : 'A very good morning...!' ,
                
                },
                 
                  'data' : {
                    'type' : 'msj' ,
                    'id' : ' Hello world'
                  }
                };

                await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                body: jsonEncode(data) ,
                  headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                    'Authorization' : 'key=AAAA_hnOFRQ:APA91bGyBWi1ZIMMJaogHcL4wqKGaHQKqK8qczCQDjgGuSXvEAnJzY8uGpT9gyBzWaZtzC7-8VjkXVLuPCwC_Tbo9gamqP7VczLFmKxea_pSQvqNlZtKSpHUJ7h0THLHThx495ZdapU_'
                  }
                ).then((value){
                  if (kDebugMode) {
                    print(value.body.toString());
                  }
                }).onError((error, stackTrace){
                  if (kDebugMode) {
                    print(error);
                  }
                });
              });
            },
                child: Text('Send Notifications')),

                //***************** */

                TextButton(onPressed: () async {
                  await notificationServices.scheduleNotificationInTimeZone();
                }, child: Text("TimeZone notifi..."))
          ],
        ),
      ),
    );
  }
}