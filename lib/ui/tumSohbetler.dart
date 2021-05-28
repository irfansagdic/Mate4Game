import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate4game/models/tumSohbetlerJson.dart';
import 'package:mate4game/services/database.dart';
import 'package:mate4game/ui/uyeGirisliAnasayfa.dart';
import 'package:mate4game/ui/uyeGirisliAppBar.dart';
import 'package:mate4game/widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class tumSohbetler extends StatefulWidget {
  @override
  _tumSohbetlerState createState() => _tumSohbetlerState();
}

class _tumSohbetlerState extends State<tumSohbetler> {
  String _uyeGirisYapanMail;

  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> getVeriler() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var _mail = await pref.getString("mail");
    return _mail;
  }

  final _firestoreInstance = FirebaseFirestore.instance;

  _sayfaFonk(int iSay) {
    if (iSay == 0) {
      Get.offAll(uyeGirisliPaylasimlar(
        gelenSayfaNo: 0,
      ));
    } else if (iSay == 1) {
      Get.offAll(uyeGirisliPaylasimlar(
        gelenSayfaNo: 1,
      ));
    } else if (iSay == 2) {
      Get.offAll(uyeGirisliPaylasimlar(
        gelenSayfaNo: 2,
      ));
    } else if (iSay == 3) {
      Get.offAll(uyeGirisliPaylasimlar(
        gelenSayfaNo: 3,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: uyeGirisliAppBar(),
        body: FutureBuilder(
          future: getVeriler(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder(
                future: services.ozelIdleriGetir(snapshot.data),
                builder:
                    (context, AsyncSnapshot<List<tumSohbetlerJson>> veriler) {
                  if (veriler.hasData) {
                    return ListView.builder(
                      itemCount: veriler.data.length,
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
                                  backgroundImage:
                                      NetworkImage(veriler.data[index].resim),
                                  backgroundColor: Colors.transparent,
                                ),
                                Text(
                                  veriler.data[index].uyeAd +
                                      " " +
                                      veriler.data[index].uyeSoyad,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            title: Text("sa"),
                            subtitle: Text("as"),
                            trailing: InkWell(
                              onTap: () {
                                /* if (snapshot.data[index].uyeMail != _sGondericiMail) {
                                 Navigator.of(context).push(MaterialPageRoute(
                                     builder: (context) => clsMesaj(
                                       sAliciMail: snapshot.data[index].uyeMail,
                                       sGondericiMail: _sGondericiMail,
                                       sAd: snapshot.data[index].uyeAd,
                                       sSoyad: snapshot.data[index].uyeSoyad,
                                     )));
                               } else {
                                 print("Kendine Mesaj Gönderemezsin");
                               }*/
                              },
                              child: Icon(Icons.mail),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        bottomNavigationBar: CustomBottomAppBar(
          page: 0,
          press: _sayfaFonk,
        ));
  }

  /* sohbet(var mail) {
    print(mail);
    var _snapshot = _firestoreInstance
        .collection("mesajlar")
        .where("id_1", isEqualTo: "salihcncengel@gmail.com")
        .orderBy("SonMesajTarih", descending: true)
        .snapshots();
    var _MagoveSalo = _snapshot.map((mesajListesi) => mesajListesi.docs
        .map((mesaj) => tumSohbetlerr.fromMap(mesaj.data()))
        .toList());
    return _MagoveSalo;
  }*/
}
