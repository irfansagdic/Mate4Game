import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mate4game/models/gonderi.dart';
import 'package:mate4game/models/oyun.dart';
import 'package:mate4game/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String sProfilFoto = "";
  SharedPreferences pref;
  String sAdi = "";
  String sSoyadi = "";
  String sMail = "";
  var valueKat = "1";
  String sGonderiId = "";
  TextEditingController textController1;
  bool showEditButton = false;
  File uploadimage;
  String _ad, _soyad;
  String _sifre = "";
  String _gonderi = "";
  var key0 = GlobalKey<FormFieldState>();
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();
  var key3 = GlobalKey<FormFieldState>();

  Future<void> chooseImage() async {
    var choosedimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      uploadimage = choosedimage;
    });
    if (uploadimage != null) {
      List<int> imageBytes = uploadimage.readAsBytesSync();
      String baseimage = base64Encode(imageBytes);
      var result = await services.profilResmi(baseimage, sMail);
      var jsonData = json.decode(result);
      if (jsonData["sonuc"] == "basarili") {
        var resim = jsonData["resim"];
        setState(() {
          pref.setString("profilfoto",
              "http://xn--temizliimnet-jyb.com/mate4game/images/" + resim);
          getVeriler();
        });
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          //this means the user must tap a button to exit the Alert Dialog
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Bilgi Mesajı'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Profil Resmi Güncellendi'),
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
      } else {
        setState(() {
          pref.setString("profilfoto",
              "https://t3.ftcdn.net/jpg/01/18/01/98/360_F_118019822_6CKXP6rXmVhDOzbXZlLqEM2ya4HhYzSV.jpg");
          getVeriler();
        });
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          //this means the user must tap a button to exit the Alert Dialog
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
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVeriler();
    // SharedPreferences.getInstance().then((sf) => mySharedPrefences = sf);
  }

  Future<dynamic> getVeriler() async {
    pref = await SharedPreferences.getInstance();
    var deneme = await pref.getString("profilfoto");
    var adi = await pref.getString("ad");
    var soyadi = await pref.getString("soyad");
    var mail = await pref.getString("mail");

    setState(() {
      sProfilFoto = deneme;
      sAdi = adi;
      sSoyadi = soyadi;
      sMail = mail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    //chooseImage();
                    setState(() {
                      //showEditButton = true;
                      chooseImage();
                    });
                  },
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(sProfilFoto),
                  ),
                ),
                if (showEditButton)
                  Positioned(
                    child: RaisedButton(
                      child: Text(''),
                      onPressed: () {},
                    ),
                  )
              ],
            ),
            SizedBox(height: 10),
            InkWell(
              onLongPress: () {
                return showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Bilgilerini Güncelle'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            TextFormField(
                              key: key0,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Adınız',
                                hintText: 'Adınızı Yazınız',
                              ),
                              initialValue: sAdi,
                              validator: (String value) {
                                if (value.length < 2) {
                                  return "Adınız 2 harften küçük olamaz";
                                }
                              },
                              onSaved: (deger) => _ad = deger,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              key: key1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Soyadınız',
                                hintText: 'Soyadınızı Yazınız',
                              ),
                              initialValue: sSoyadi,
                              validator: (String value) {
                                if (value.length < 2) {
                                  return "Soyadınız 2 harften küçük olamaz";
                                }
                              },
                              onSaved: (deger) => _soyad = deger,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              key: key2,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Yeni Şifre',
                                hintText: 'Yeni Şifrenizi Yazınız',
                              ),
                              validator: (String value) {
                                if (value.length <= 0) {
                                  return "Şifreniz 6 harften küçük olamaz";
                                }
                              },
                              onSaved: (deger) => _sifre = deger,
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('OK'),
                          onPressed: () {
                            uyeBilgileriGuncelle();
                          },
                        ),
                        FlatButton(
                          child: Text('İptal'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                sAdi + " " + sSoyadi,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(color: Colors.black),
            SizedBox(
              height: 10,
            ),
            Text(
              "GÖNDERİLERİNİZ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            gonderilerimm(),
          ],
        ),
      ),
    );
  }

  gonderilerimm() {
    return FutureBuilder(
      future: services.getGonderilerim(sMail),
      builder: (context, AsyncSnapshot<List<gonderilerim>> snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  elevation: 10,
                  child: ListTile(
                    leading: Column(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(sProfilFoto),
                          backgroundColor: Colors.transparent,
                        ),
                        Text(
                          sAdi + " " + sSoyadi,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    title: Text(snapshot.data[index].oyunAdi),
                    subtitle: Text(snapshot.data[index].gonderi),
                    trailing: Column(
                      children: [
                        InkWell(
                          child: Icon(Icons.edit),
                          onTap: () {
                            valueKat = snapshot.data[index].oyunId;
                            sGonderiId = snapshot.data[index].id;
                            return showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return AlertDialog(
                                    title: Text('Gönderi Düzenle'),
                                    content: SingleChildScrollView(
                                      child: Column(children: [
                                        TextFormField(
                                          key: key3,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Gönderi',
                                            hintText: 'Gönderinizi Düzenleyin',
                                          ),
                                          initialValue:
                                              snapshot.data[index].gonderi,
                                          validator: (String valeue) {
                                            if (valeue.length < 10) {
                                              return "Gönderiniz 10 karakterden küçük olamaz";
                                            }
                                          },
                                          onSaved: (degerval) {
                                            _gonderi = degerval;
                                          },
                                          onChanged: (value) {
                                            if (value.length < 11) {
                                            } else {
                                              _gonderi = value;
                                            }
                                          },
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(16),
                                          child: FutureBuilder(
                                            future: services.getOyun(),
                                            builder: (context,
                                                AsyncSnapshot<List<oyun>>
                                                    snapshott) {
                                              if (snapshott.hasData) {
                                                return DropdownButton<String>(
                                                  items: snapshott.data
                                                      .map((fc) =>
                                                          DropdownMenuItem<
                                                                  String>(
                                                              child: Text(
                                                                  fc.oyunAdi),
                                                              value: fc.oyunId
                                                                  .toString()))
                                                      .toList(),
                                                  isExpanded: true,
                                                  value: valueKat,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      valueKat = newValue;
                                                    });
                                                  },
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ]),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          gonderiDuzenle(
                                              _gonderi, valueKat, sGonderiId);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                              },
                            );
                          },
                        ),
                        InkWell(
                          child: Icon(Icons.delete),
                          onTap: () {
                            return showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Bilgi Mesajı'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Silmek İstediğinize Emin Misiniz ? '),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('OK'),
                                      onPressed: () async {
                                        var result = await services
                                            .gonderSil(snapshot.data[index].id);
                                        if (result == "basarili") {
                                          Navigator.pop(context);
                                          setState(() {
                                            gonderilerimm();
                                          });
                                        }
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> uyeBilgileriGuncelle() async {
    veriKontrol();
    var result =
        await services.uyeBilgileriGuncelle(_ad, _soyad, sMail, _sifre);
    if (result == "basarili") {
      setState(() {
        pref.setString("ad", _ad);
        pref.setString("soyad", _soyad);
        if (_sifre != "") {
          pref.setString("sifre", _sifre);
        }
        getVeriler();
      });
      Navigator.pop(context);
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bilgi'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Bilgileriniz Güncellendi.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  /*Navigator.pushNamed(
                                    context, '/uyeGirisliAnasayfa');*/
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  void veriKontrol() {
    if (key0.currentState.validate()) {
      key0.currentState.save();
    }
    if (key1.currentState.validate()) {
      key1.currentState.save();
    }
    if (key2.currentState.validate()) {
      key2.currentState.save();
    }
  }

  void veriKontrolGonderi() {
    if (key3.currentState.validate()) {
      key3.currentState.save();
    }
  }

  Future<void> gonderiDuzenle(
      String gonderii, String oyunKategori, String sGonderiIdd) async {
    veriKontrolGonderi();
    if (gonderii.length > 11) {
      var result =
          await services.gonderiGuncelle(gonderii, oyunKategori, sGonderiIdd);
      if (result == "basarili") {
        Navigator.pop(context);
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
                    Text('Başarıyla Güncellendi'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      gonderilerimm();
                    });
                  },
                ),
              ],
            );
          },
        );
      } else {
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
                    Text('Güncelleme Başarısız'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      gonderilerimm();
                    });
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}
