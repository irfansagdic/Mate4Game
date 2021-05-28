import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mate4game/ui/uyeGirissizAnasayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'uyeGirisliAnasayfa.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences mySharedPrefences;
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((message) {
      /* RemoteNotification notification = message.data as RemoteNotification;
      print(notification);*/
      flutterLocalNotificationsPlugin.show(
        0,
        message.data["title"],
        message.data["message"],
        NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id, channel.name, channel.description,
              importance: Importance.high,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher'),
          iOS: IOSNotificationDetails(),
        ),
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Navigator.pushNamed(context, "/Mesaj");

      /*print("selamm");
      Map<String, dynamic> notification = message.data;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.length.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.length.toString())],
                  ),
                ),
              );
            });
      }*/
    });

    SharedPreferences.getInstance().then((sf) => mySharedPrefences = sf);

    Future.delayed(Duration(seconds: 3), () {
      if (mySharedPrefences.getString("ad") != null) {
        Get.offAll(uyeGirisliPaylasimlar());
      } else {
        Get.offAll(Paylasimlar());
      }
      /*Navigator.push(context,
          MaterialPageRoute(builder: (context) => uyeGirisliPaylasimlar()));*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splashscreen.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
