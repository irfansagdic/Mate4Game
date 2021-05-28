import 'package:flutter/material.dart';
import 'package:mate4game/models/tumGonderiler.dart';
import 'package:mate4game/services/database.dart';
import 'package:mate4game/ui/mesaj.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gonderiler extends StatefulWidget {
  @override
  GonderilerState createState() => GonderilerState();
}

class GonderilerState extends State<Gonderiler> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVeriler();
    //  tokenYazdir();
  }

  /*tokenYazdir() async {
    FirebaseMessaging.instance.getToken().then((value) {
      print("print:" + value);
    });
  }*/

  String _sGondericiMail;
  String _sBenimAdimm;
  String _sBenimSoyadimm;
  Future<dynamic> getVeriler() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var mail = await pref.getString("mail");
    var _ad = await pref.getString("ad");
    var _soyad = await pref.getString("soyad");
    setState(() {
      _sGondericiMail = mail;
      _sBenimAdimm = _ad;
      _sBenimSoyadimm = _soyad;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: services.getTumGonderilerim(),
      builder: (context, AsyncSnapshot<List<tumGonderiler>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
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
                          backgroundImage: NetworkImage(snapshot
                                      .data[index].uyeProfil
                                      .toString()
                                      .trim() ==
                                  ""
                              ? "https://t3.ftcdn.net/jpg/01/18/01/98/360_F_118019822_6CKXP6rXmVhDOzbXZlLqEM2ya4HhYzSV.jpg"
                              : "http://xn--temizliimnet-jyb.com/mate4game/images/" +
                                  snapshot.data[index].uyeProfil),
                          backgroundColor: Colors.transparent,
                        ),
                        Text(
                          snapshot.data[index].uyeAd +
                              " " +
                              snapshot.data[index].uyeSoyad,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    title: Text(snapshot.data[index].oyunAdi),
                    subtitle: Text(snapshot.data[index].gonderi),
                    trailing: InkWell(
                      onTap: () {
                        if (_sBenimAdimm != null) {
                          if (snapshot.data[index].uyeMail != _sGondericiMail) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => clsMesaj(
                                    sAliciMail: snapshot.data[index].uyeMail,
                                    sGondericiMail: _sGondericiMail,
                                    sAd: snapshot.data[index].uyeAd,
                                    sSoyad: snapshot.data[index].uyeSoyad,
                                    sBenimAdim: _sBenimAdimm,
                                    sBenimSoyadim: _sBenimSoyadimm)));
                          } else {
                            print("Kendine Mesaj Gönderemezsin");
                          }
                        } else {
                          return showDialog<void>(
                            context: context,
                            barrierDismissible: true, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('AlertDialog Title'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: const <Widget>[
                                      Text(
                                          'Mesaj Atmak İçin Üye Giriş Yapmalısınız'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Üye Giriş'),
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/uyeGiris");
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Kayıt Ol'),
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/uyeKayit");
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Icon(Icons.mail),
                    )),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
