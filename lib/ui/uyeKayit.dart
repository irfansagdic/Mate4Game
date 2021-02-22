import 'package:flutter/material.dart';
import 'package:mate4game/ui/uyeGirissizAppBar.dart';

class uyeKayit extends StatefulWidget {
  @override
  uyeKayitState createState() => uyeKayitState();
}

class uyeKayitState extends State<uyeKayit> {
  int _aktifStep = 0;
  String ad, soyad, mail, sTekrarSifre, sSifre;
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
                  child: const Text('Devam Et!'),
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
          /*onStepTapped: (tiklanilanStep) {
            setState(() {
              _aktifStep = tiklanilanStep;
            });
          },*/
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
              if (girilenDeger.length < 6 ||
                  !girilenDeger.contains(
                      "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")) {
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
}
