import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate4game/models/gonderi.dart';
import 'package:mate4game/services/database.dart';
import 'package:mate4game/ui/uyeGirisliAnasayfa.dart';
import 'package:mate4game/ui/uyeGirisliAppBar.dart';
import 'package:mate4game/widgets/custom_app_bar.dart';

class userProfilPage extends StatefulWidget {
  final int uyeId;
  userProfilPage({Key key, this.uyeId}) : super(key: key);

  @override
  _userProfilPageState createState() => _userProfilPageState();
}

class _userProfilPageState extends State<userProfilPage> {
  String sUyeAd, sUyeSoyad, sUyeMail, sUyeResim;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bilgileriCek(widget.uyeId);
  }

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
        //    body: Gonderiler(),
        body: Center(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(sUyeResim == ""
                        ? "https://t3.ftcdn.net/jpg/01/18/01/98/360_F_118019822_6CKXP6rXmVhDOzbXZlLqEM2ya4HhYzSV.jpg"
                        : "http://xn--temizliimnet-jyb.com/mate4game/images/" +
                            sUyeResim),
                  ),
                ],
              ),
              SizedBox(height: 10),
              InkWell(
                child: Text(
                  sUyeAd + " " + sUyeSoyad,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Divider(color: Colors.black),
              SizedBox(
                height: 10,
              ),
              Text(
                "ÜYENİN GÖNDERİLERİ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              gonderiler(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomAppBar(
          page: 1,
          press: _sayfaFonk,
        ));
  }

  gonderiler() {
    return FutureBuilder(
      future: services.getGonderilerim(sUyeMail),
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
                          backgroundImage: NetworkImage(sUyeResim == ""
                              ? "https://t3.ftcdn.net/jpg/01/18/01/98/360_F_118019822_6CKXP6rXmVhDOzbXZlLqEM2ya4HhYzSV.jpg"
                              : "http://xn--temizliimnet-jyb.com/mate4game/images/" +
                                  sUyeResim),
                          backgroundColor: Colors.transparent,
                        ),
                        Text(
                          sUyeAd + " " + sUyeSoyad,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    title: Text(snapshot.data[index].oyunAdi),
                    subtitle: Text(snapshot.data[index].gonderi),
                    trailing: Icon(Icons.mail),
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

  bilgileriCek(int iUyeId) async {
    var result = await services.userProfili(iUyeId);
    setState(() {
      sUyeAd = result.uyeAd;
      sUyeSoyad = result.uyeSoyad;
      sUyeMail = result.uyeMail;
      sUyeResim = result.uyeProfil;
    });

    /* var map = json.decode(result);
    print(map["uyeAd"]);*/
  }
}
