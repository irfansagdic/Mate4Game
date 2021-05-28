import 'package:flutter/material.dart';
import 'package:mate4game/models/user.dart';
import 'package:mate4game/services/database.dart';

class deneme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: FutureBuilder(
        future: services.getUser(),
        builder: (context, AsyncSnapshot<user> snap) {
          if (snap.hasData) {
            return Center(
              child: Text(snap.data.uyeAd),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ));
  }
}
