import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate4game/services/database.dart';
import 'package:mate4game/ui/uyeGiris.dart';
import 'package:mate4game/ui/uyeGirisliAnasayfa.dart';
import 'package:mate4game/ui/uyeGirissizAppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class uyeKayit extends StatefulWidget {
  @override
  uyeKayitState createState() => uyeKayitState();
}

class uyeKayitState extends State<uyeKayit> {
  var mySharedPrefences;
  int _aktifStep = 0;
  String ad, soyad, mail, sTekrarSifre, sSifre;
  String _sToken;
  List<Step> tumStepler;
  bool hata = false;
  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();
  var key3 = GlobalKey<FormFieldState>();
  var key4 = GlobalKey<FormFieldState>();
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

  uyeKayitFonk() async {
    var result = await services.uyeKayit(ad, soyad, mail, sSifre, _sToken);
    result = result.trim();
    // print(result);
    // print(result);
    if (result == "Email Hata") {
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
                  Text('Bu Mail Zaten Üye veya Üyeliği Aktif Edilmemiştir.'),
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
    } else if (result == "pasif") {
      return showDialog<void>(
        context: context,
        barrierDismissible:
            false, //this means the user must tap a button to exit the Alert Dialog
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bilgi Mesajı'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Mail Adresinizden Üyeliğinizi Aktif Hale Getirip,Butona Basınız'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Aktif Et'),
                onPressed: () async {
                  var mailKontrolEt = await services.mailKontrol(mail);
                  //  print(mailKontrolEt);
                  if (mailKontrolEt == "aktifdegil") {
                    Navigator.pop(context);
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hata'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                    'Mailinize gelen linke tıklamadığınız için üyeliğiniz aktif edilmedi.'
                                    'Üye Giriş Ekranına Yönlendirileceksiniz'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Üye Girişi'),
                              onPressed: () {
                                Get.offAll(uyeGiris());
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else if (mailKontrolEt == "aktifedildi") {
                    Navigator.pop(context);
                    _SharedPreferencesEkle();
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Hata'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(
                                    'Üyeliğiniz Aktif Edildi,Anasayfa Ekranına Yönlendiriliyorsunuz'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Anasayfa'),
                              onPressed: () {
                                /*Navigator.pushNamed(
                                    context, '/uyeGirisliAnasayfa');*/
                                Get.offAll(uyeGirisliPaylasimlar());
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    tumStepler = _tumStepler();
    return Scaffold(
      appBar: uyeGirissizAppBar(),
      body: SingleChildScrollView(
        child: Stepper(
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  onPressed: onStepContinue,
                  child: _aktifStep == 4
                      ? const Text('Kaydı Tamamla')
                      : const Text('Devam Et!'),
                ),
                SizedBox(
                  width: 30,
                ),
                RaisedButton(
                  // color: Colors.pink,
                  onPressed: onStepCancel,
                  child: const Text('Geri Gel'),
                ),
              ],
            );
          },
          steps: _tumStepler(),
          currentStep: _aktifStep,
          onStepContinue: () {
            setState(() {
              ileriButonKontrol();
            });
          },
          onStepCancel: () {
            setState(() {
              if (_aktifStep > 0) {
                _aktifStep--;
              } else {
                _aktifStep = 0;
              }
            });
          },
        ),
      ),
    );
  }

  List<Step> _tumStepler() {
    List<Step> stepler = [
      Step(
        title: Text("Adınızı Giriniz"),
        isActive: true,
        content: TextFormField(
          key: key0,
          decoration:
              InputDecoration(hintText: "Adınız", border: OutlineInputBorder()),
          validator: (girilenDeger) {
            if (girilenDeger.length < 2) {
              return "Adınız 2 Harften küçük olamaz";
            }
          },
          onSaved: (girilenDeger) {
            ad = girilenDeger;
          },
        ),
      ),
      Step(
        title: Text("Soyadınızı Giriniz"),
        isActive: true,
        content: TextFormField(
            key: key1,
            decoration: InputDecoration(
                hintText: "Soyad", border: OutlineInputBorder()),
            validator: (girilenDeger) {
              if (girilenDeger.length < 2) {
                return "Soyadınız 2 Harften küçük olamaz";
              }
            },
            onSaved: (girilenDeger) {
              soyad = girilenDeger;
            }),
      ),
      Step(
        title: Text("Email Giriniz"),
        isActive: true,
        content: TextFormField(
            key: key2,
            decoration: InputDecoration(
                hintText: "Email", border: OutlineInputBorder()),
            validator: (girilenDeger) {
              if (girilenDeger.length < 6) {
                return "Geçersiz Email";
              }
            },
            onSaved: (girilenDeger) {
              mail = girilenDeger;
            }),
      ),
      Step(
        title: Text("Şifrenizi Giriniz"),
        isActive: true,
        content: TextFormField(
            key: key3,
            decoration: InputDecoration(
                hintText: "Şifre", border: OutlineInputBorder()),
            validator: (girilenDeger) {
              if (girilenDeger.length < 6) {
                return "Şifrenizi en az 6 uzunlukta olmadı";
              } else {
                sSifre = girilenDeger;
              }
            },
            onSaved: (girilenDeger) {
              sSifre = girilenDeger;
            }),
      ),
      Step(
        title: Text("Şifrenizi Tekrar Giriniz"),
        isActive: true,
        content: TextFormField(
            key: key4,
            decoration: InputDecoration(
                hintText: "Şifre Tekrar", border: OutlineInputBorder()),
            validator: (girilenDeger) {
              if (girilenDeger != sSifre) {
                return "Şifreler Uyuşmuyor";
              }
            },
            onSaved: (girilenDeger) {
              sTekrarSifre = girilenDeger;
              uyeKayitFonk();
            }),
      ),
    ];
    return stepler;
  }

  void ileriButonKontrol() {
    switch (_aktifStep) {
      case 0:
        if (key0.currentState.validate()) {
          key0.currentState.save();
          hata = false;
          _aktifStep++;
        } else {
          hata = true;
        }
        break;
      case 1:
        if (key1.currentState.validate()) {
          key1.currentState.save();
          hata = false;
          _aktifStep++;
        } else {
          hata = true;
        }
        break;
      case 2:
        if (key2.currentState.validate()) {
          key2.currentState.save();
          hata = false;
          _aktifStep++;
        } else {
          hata = true;
        }
        break;
      case 3:
        if (key3.currentState.validate()) {
          key3.currentState.save();
          hata = false;
          _aktifStep++;
        } else {
          hata = true;
        }
        break;
      case 4:
        if (key4.currentState.validate()) {
          key4.currentState.save();
          hata = false;
        } else {
          hata = true;
        }
        break;
    }
  }

  void _SharedPreferencesEkle() async {
    await (mySharedPrefences as SharedPreferences).setString("ad", ad);
    await (mySharedPrefences as SharedPreferences).setString("soyad", soyad);
    await (mySharedPrefences as SharedPreferences).setString("mail", mail);
    await (mySharedPrefences as SharedPreferences).setString("sifre", sSifre);
    await (mySharedPrefences as SharedPreferences).setString("token", _sToken);
    await (mySharedPrefences as SharedPreferences).setString("profilfoto",
        "https://t3.ftcdn.net/jpg/01/18/01/98/360_F_118019822_6CKXP6rXmVhDOzbXZlLqEM2ya4HhYzSV.jpg");
  }
}
