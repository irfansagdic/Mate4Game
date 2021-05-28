import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mate4game/models/mesaj.dart';
import 'package:mate4game/services/database.dart';

class clsMesaj extends StatefulWidget {
  const clsMesaj(
      {this.sAliciMail,
      this.sGondericiMail,
      this.sAd,
      this.sSoyad,
      this.sBenimAdim,
      this.sBenimSoyadim});

  @override
  _clsMesajState createState() => _clsMesajState();

  final String sAliciMail;
  final String sGondericiMail;
  final String sAd;
  final String sSoyad;
  final String sBenimAdim;
  final String sBenimSoyadim;
}

class _clsMesajState extends State<clsMesaj> {
  // final databaseReference = FirebaseDatabase.instance.reference();
  var _tumMesajlar = [];
  List _asilTumMesajlar = [];
  final firestoreInstance = FirebaseFirestore.instance;
  var _sonMesajTarihi;
  String _OzelIdMesaj = "";
  String _sAliciToken = "";
  var MesajGonderController = TextEditingController();
  ScrollController controller = new ScrollController();
  int iElemanSayisi;
  /*_scrollListener() {
    print("scroll listener fonk");
    if (controller.offset >= controller.position.minScrollExtent &&
        !controller.position.outOfRange) {
      print("scroll yukari kaydi fonk girdi");
      setState(() {
        print("scroll yukari kaydi set state");
        yeniMesajlariYukle(_OzelIdMesaj);
      });
    }
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAliciToken();
    // controller.addListener(_scrollListener);
  }

  _getAliciToken() async {
    var result = await services.getAliciToken(widget.sAliciMail);
    _sAliciToken = result;
  }

  Future<void> getOzelId() async {
    var result =
        await services.OzelIdGetir(widget.sAliciMail, widget.sGondericiMail);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sAd + " " + widget.sSoyad),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Expanded(
                child: FutureBuilder(
                  future: getOzelId(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _OzelIdMesaj = snapshot.data;
                      return StreamBuilder(
                        stream: mesajlariListele(snapshot.data),
                        builder: (context, StreamMesajlariListesle) {
                          _tumMesajlar = StreamMesajlariListesle.data as List;
                          if (!StreamMesajlariListesle.hasData) {
                            print("ife girdi");
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (_tumMesajlar.length == 0) {
                              iElemanSayisi = 0;
                              print("selam");
                            } else {
                              iElemanSayisi = _tumMesajlar.length;
                              print("as");
                            }
                            //   _sonMesajTarihi = _tumMesajlar.last;
                            _asilTumMesajlar
                                .addAll((StreamMesajlariListesle.data as List));

                            _sonMesajTarihi = _asilTumMesajlar.last.Date;

                            return ListView.builder(
                              reverse: true,
                              controller: controller,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 10, bottom: 60),
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.only(
                                      left: 14, right: 14, top: 10, bottom: 10),
                                  child: Align(
                                    alignment: (_tumMesajlar[index].Gonderici ==
                                            widget.sAliciMail
                                        ? Alignment.topLeft
                                        : Alignment.topRight),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: (_tumMesajlar[index].Gonderici ==
                                                widget.sAliciMail
                                            ? Colors.grey.shade200
                                            : Colors.blue[200]),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Text(
                                        _tumMesajlar[index].mesaj,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: _tumMesajlar.length,
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
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Mesajınızı Yazınız...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                      controller: MesajGonderController,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (MesajGonderController.text.trim() != null) {
                        MesajKayit(MesajGonderController.text);

                        MesajGonderController.text = "";
                      }
                      // mesajlariListele(_OzelIdMesaj);
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void MesajKayit(String _sMesaj) async {
    firestoreInstance.collection("mesajlar").doc(_OzelIdMesaj).set({
      'id_1': widget.sGondericiMail,
      'id_2': widget.sAliciMail,
      'SonMesaj': _sMesaj,
      'SonMesajTarih': FieldValue.serverTimestamp()
    });

    var _firebaseOzelId = firestoreInstance
        .collection("mesajlar")
        .doc(_OzelIdMesaj)
        .collection("konusmalar")
        .doc()
        .id
        .toString();
    firestoreInstance
        .collection("mesajlar")
        .doc(_OzelIdMesaj)
        .collection("konusmalar")
        .doc(_firebaseOzelId)
        .set({
      'Alici': widget.sAliciMail,
      'Gonderici': widget.sGondericiMail,
      'Mesaj': _sMesaj,
      'Date': FieldValue.serverTimestamp(),
    });
    bildirimGonder(_sMesaj, widget.sBenimAdim, widget.sBenimSoyadim);
  }

  mesajlariListele(String _ozelIdMesajj) {
    var snapshot = firestoreInstance
        .collection("mesajlar")
        .doc(_ozelIdMesajj)
        .collection("konusmalar")
        .orderBy("Date", descending: true)
        .snapshots();

    if (snapshot.length != 0) {
      return snapshot.map((mesajListesi) => mesajListesi.docs
          .map((mesaj) => Mesaj.fromMap(mesaj.data()))
          .toList());
    } else {
      return Container();
    }
  }

  yeniMesajlariYukle(String _ozelIdMesajj) {
    /*var snapshot = firestoreInstance
        .collection("mesajlar")
        .doc(_ozelIdMesajj)
        .collection("konusmalar")
        // .where('Date', isEqualTo: _sonMesajTarihi)
        .orderBy("Date", descending: true)
        .startAfter([
          {'mesaj': "df"}
        ])
        .limit(10)
        .get()
        .then((value) {
          value.docs.forEach((element) {
            print("Burdaki:" + element.data().toString());
          });
        });*/
    /*   print("yenimesajyuke");
    print(_asilTumMesajlar);
    var snapshot = firestoreInstance
        .collection("mesajlar")
        .doc(_ozelIdMesajj)
        .collection("konusmalar")
        // .where('Date', isEqualTo: _sonMesajTarihi)
        .orderBy("Date", descending: true)
        .startAfter([
          {'Date': _sonMesajTarihi}
        ])
        .limit(9)
        .snapshots();

    return snapshot.map((mesajListesi) =>
        mesajListesi.docs.map((mesaj) => Mesaj.fromMap(mesaj.data())).toList());*/
  }

  bildirimGonder(String _sGonderMesaj, String _ssAd, _ssSoyad) async {
    print("Token=" + _sAliciToken);
    String _sEndUrl = "https://fcm.googleapis.com/fcm/send";
    String _sFirebaseKey =
        "AAAAh5mreTc:APA91bE028sMR0QIO4em00i5M3UCFufiEN3rP8F3yFs7g5MNSOssdy80KDMz0tJ8_9hvXO1-1QsyDMM1CyXoDcy3LUlivfD0kILXNv9oUfO5gIjrxdeqE6yHdL57Jq-Iiqq7MA_EuyXS";
    Map<String, String> _headers = {
      "Content-type": "application/json",
      "Authorization": "key=$_sFirebaseKey",
    };
    String _sTitle = _ssAd + " " + _ssSoyad;
    String _json =
        '{ "to":"$_sAliciToken" , "data":{"message":"$_sGonderMesaj","title":"$_sTitle" } }';
    http.Response response =
        await http.post(_sEndUrl, headers: _headers, body: _json);
    if (response.statusCode == 200) {
      print("basarili");
      /* FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = response as RemoteNotification;
        print(notification);
        AndroidNotification android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
        }
      });*/
    } else {
      print("hata");
    }
  }
}
