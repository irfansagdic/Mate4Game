import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate4game/services/database.dart';
import 'package:mate4game/ui/uyeGirisliAnasayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'uyeGirissizAppBar.dart';

class uyeGiris extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return uyeGirisState();
  }
}

class uyeGirisState extends State<uyeGiris> {
  String _mail, _sifre, _sToken;
  var mySharedPrefences;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sf) => mySharedPrefences = sf);
    tokenYazdir();
  }

  tokenYazdir() async {
    FirebaseMessaging.instance.getToken().then((value) {
      _sToken = value;
    });
  }

  final formKeyGiris = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: uyeGirissizAppBar(),
      body: Form(
        key: formKeyGiris,
        autovalidate: true,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'abc@gmail.com'),
                    validator: (String value) {
                      if (value.length < 6) {
                        return "Mailiniz 6'dan küçük olamaz";
                      }
                    },
                    onSaved: (deger) => _mail = deger,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Şifre',
                        hintText: 'Şifrenizi Yazınız'),
                    validator: (String value) {
                      if (value.length < 6) {
                        return "Şifreniz 6'dan küçük olamaz";
                      }
                    },
                    onSaved: (deger) => _sifre = deger,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                  },
                  child: Text(
                    'Şifrenizi mi Unuttunuz ?',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      if (formKeyGiris.currentState.validate()) {
                        formKeyGiris.currentState.save();
                        uyeGirisFonk();
                      }
                    },
                    child: Text(
                      'Giriş',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/uyeKayit");
                  },
                  child: Text('New User ? Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void uyeGirisFonk() async {
    var result = await services.uyeGiris(_mail, _sifre, _sToken);

    var map = json.decode(result);

    if (map["giris"] == "basarisiz") {
      return showDialog<void>(
        context: context,
        barrierDismissible:
            false, //this means the user must tap a button to exit the Alert Dialog
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata Mesajı'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Giriş Başarısız'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else if (map["giris"] == "basarili") {
      await (mySharedPrefences as SharedPreferences)
          .setString("ad", map["bilgi"]["uyeAd"]);
      await (mySharedPrefences as SharedPreferences)
          .setString("soyad", map["bilgi"]["uyeSoyad"]);
      await (mySharedPrefences as SharedPreferences)
          .setString("mail", map["bilgi"]["uyeMail"]);
      await (mySharedPrefences as SharedPreferences)
          .setString("sifre", map["bilgi"]["uyeSifre"]);
      await (mySharedPrefences as SharedPreferences)
          .setString("token", map["bilgi"]["token"]);

      if (map["bilgi"]["uyeProfil"] == null ||
          map["bilgi"]["uyeProfil"] == "" ||
          map["bilgi"]["uyeProfil"] == " ") {
        await (mySharedPrefences as SharedPreferences).setString("profilfoto",
            "https://t3.ftcdn.net/jpg/01/18/01/98/360_F_118019822_6CKXP6rXmVhDOzbXZlLqEM2ya4HhYzSV.jpg");
      } else {
        await (mySharedPrefences as SharedPreferences).setString(
            "profilfoto",
            "http://xn--temizliimnet-jyb.com/mate4game/images/" +
                map["bilgi"]["uyeProfil"]);
      }
      Get.offAll(uyeGirisliPaylasimlar());
    }
  }
}
