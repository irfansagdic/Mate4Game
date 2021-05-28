import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mate4game/ui/mesaj.dart';
import 'package:mate4game/ui/splashScreen.dart';
import 'package:mate4game/ui/tumSohbetler.dart';
import 'package:mate4game/ui/uyeGiris.dart';
import 'package:mate4game/ui/uyeGirisliAnasayfa.dart';
import 'package:mate4game/ui/uyeKayit.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(message) async {
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
              icon: '@mipmap/ic_launcher')));
  /*print("buraya girdi");
  print(message);

  if (message.containsKey('data')) {
    print("salih");
  }
  if (message.containsKey('notificaion')) {
    print("as");
  }*/
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(
    new GetMaterialApp(
      title: "Mate4Game",
      routes: {
        '/': (context) => SplashScreen(),
        //'/': (context) => deneme(),
        '/uyeKayit': (context) => uyeKayit(),
        '/uyeGirisliAnasayfa': (context) => uyeGirisliPaylasimlar(),
        '/uyeGiris': (context) => uyeGiris(),
        '/tumSohbetler': (context) => tumSohbetler(),
        '/Mesaj': (context) => clsMesaj(),
      },
      debugShowCheckedModeBanner: false,
      //   home: Paylasimlar(),
    ),
  );
}
