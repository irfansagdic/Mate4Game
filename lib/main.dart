import 'package:flutter/material.dart';
import 'package:mate4game/ui/uyeGirisliAnasayfa.dart';
import 'package:mate4game/ui/uyeKayit.dart';

void main() {
  runApp(
    new MaterialApp(
      title: "Mate4Game",
      routes: {
        '/': (context) => uyeGirisliPaylasimlar(),
        '/uyeKayit': (context) => uyeKayit()
      },
      debugShowCheckedModeBanner: false,
      //   home: Paylasimlar(),
    ),
  );
}
