import 'package:flutter/material.dart';
import 'package:mate4game/models/aramaHepsi.dart';
import 'package:mate4game/models/aramaOyunlarSart.dart';
import 'package:mate4game/models/gonderi.dart';
import 'package:mate4game/models/kisilerArama.dart';
import 'package:mate4game/models/oyunlarArama.dart';
import 'package:mate4game/services/database.dart';
import 'package:mate4game/ui/userProfilPage.dart';

class aramaSayfasi extends StatefulWidget {
  @override
  _aramaSayfasiState createState() => _aramaSayfasiState();
}

class _aramaSayfasiState extends State<aramaSayfasi> {
  int secim = 0;
  String sKelime = "";
  String sFiltre = "";
  int iOyunIdArama;
  int iNerdeyim = 0;

  String sUyeAd, sUyeSoyad, sUyeMail, sUyeResim;

  // List aramaFiltre = [kisioyunCard(), kisilerCard(), oyunlarCard()];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return aramaSayfasiMain();
  }

  bilgileriCek(int iUyeId) async {
    var result = await services.userProfili(iUyeId);
    setState(() {
      sUyeAd = result.uyeAd;
      sUyeSoyad = result.uyeSoyad;
      sUyeMail = result.uyeMail;
      sUyeResim = result.uyeProfil;
    });
  }

  userProfilSayfasi() {
    return Center(
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
    );
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
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.mail)],
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

  aramaSayfasiMain() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            decoration:
                InputDecoration(hintText: "Kullanıcı adı veya Oyun adı..."),
            autofocus: false,
            onChanged: (value) {
              value = value.trim();
              if ((value != "" || value != null || value != " ")) {
                setState(() {
                  sKelime = value;
                });
              } else {
                setState(() {
                  secim = 0;
                  sKelime = "";
                });
              }
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  if (sKelime != "") {
                    secim = 1;
                  }
                });
              },
              child: Text(
                "Hepsi",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (sKelime != "") {
                    secim = 2;
                    sFiltre = "kisiler";
                  }
                });
              },
              child: Text(
                "Kişiler",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (sKelime != "") {
                    secim = 3;
                    sFiltre = "oyunlar";
                  }
                });
              },
              child: Text(
                "Oyunlar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        secim != 0
            ? secim == 2
                ? aramaKisi(sKelime, sFiltre)
                : secim == 3
                    ? fAramaOyunlar(sKelime, sFiltre)
                    : secim == 4
                        ? fAramaOyunlarTap(iOyunIdArama)
                        : aramaHepsii(sKelime)
            : Expanded(
                child: SizedBox(
                height: 500,
                child: Center(
                  child: Text(
                    "Arama Yapmak İçin Text'e bir şeyler yazın",
                    style: TextStyle(fontSize: 20, color: Colors.teal),
                  ),
                ),
              )),
        /*SizedBox(
          height: 10,
        ),*/
      ],
    );
  }

  aramaHepsii(String sSearch) {
    return Expanded(
        child: FutureBuilder(
      future: services.aramaHepsii(sSearch),
      builder: (context, AsyncSnapshot<List<aramaHepsi>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              if (snapshot.data[index].soyad == " ") {
                return InkWell(
                  onTap: () {
                    setState(() {
                      secim = 4;
                      iOyunIdArama = int.parse(snapshot.data[index].id);
                    });
                  },
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    elevation: 10,
                    child: ListTile(
                      leading: Column(
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            backgroundImage:
                                NetworkImage(snapshot.data[index].resim),
                            backgroundColor: Colors.transparent,
                          ),
                          /* Text(
                      "ad soyad $index",
                      style: TextStyle(fontSize: 12),
                    ),*/
                        ],
                      ),
                      title: Text(snapshot.data[index].ad),
                      subtitle: Text("İlgili Gönderi : " +
                          snapshot.data[index].gonderiSayisi),
                    ),
                  ),
                );
              } else {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => userProfilPage(
                              uyeId: int.parse(snapshot.data[index].id),
                            )));
                  },
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(10),
                    elevation: 10,
                    child: ListTile(
                      leading: Column(
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            backgroundImage: NetworkImage(snapshot
                                            .data[index].resim ==
                                        "" ||
                                    snapshot.data[index].resim == " "
                                ? "https://t3.ftcdn.net/jpg/01/18/01/98/360_F_118019822_6CKXP6rXmVhDOzbXZlLqEM2ya4HhYzSV.jpg"
                                : "http://xn--temizliimnet-jyb.com/mate4game/images/" +
                                    snapshot.data[index].resim),
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      ),
                      title: Text(snapshot.data[index].ad +
                          " " +
                          snapshot.data[index].soyad),
                      subtitle: Text("Gönderi Sayısı : " +
                          snapshot.data[index].gonderiSayisi),
                      trailing: Icon(Icons.mail),
                    ),
                  ),
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
    ));
  }

  fAramaOyunlarTap(int iOyunId) {
    return Expanded(
        child: FutureBuilder(
      future: services.aramaOyunlarrSart(iOyunId),
      builder: (context, AsyncSnapshot<List<aramaOyunlarSart>> snapshot) {
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
                                    .data[index].uyeProfil ==
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
                  trailing: Icon(Icons.mail),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  fAramaOyunlar(String deger, String filtre) {
    // var result = await services.aramaKisiler();
    return Expanded(
        child: FutureBuilder(
      future: services.aramaOyunlarr(deger, filtre),
      builder: (context, AsyncSnapshot<List<aramaOyunlar>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    secim = 4;
                    iOyunIdArama = int.parse(snapshot.data[index].oyunId);
                  });
                },
                child: Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  elevation: 10,
                  child: ListTile(
                    leading: Column(
                      children: [
                        CircleAvatar(
                          radius: 28.0,
                          backgroundImage:
                              NetworkImage(snapshot.data[index].oyunResim),
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                    ),
                    title: Text(snapshot.data[index].oyunAdi),
                    subtitle: Text("İlgili Gönderi : " +
                        snapshot.data[index].gonderiSayisi),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  aramaKisi(String deger, String filtre) {
    // var result = await services.aramaKisiler();
    return Expanded(
        child: FutureBuilder(
      future: services.aramaKisiler(deger, filtre),
      builder: (context, AsyncSnapshot<List<kisilerArama>> snapshot) {
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
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => userProfilPage(
                                    uyeId: int.parse(snapshot.data[index].id),
                                  )));
                        },
                        child: CircleAvatar(
                          radius: 28.0,
                          backgroundImage: NetworkImage(snapshot
                                          .data[index].uyeProfil ==
                                      "" ||
                                  snapshot.data[index].uyeProfil == " "
                              ? "https://t3.ftcdn.net/jpg/01/18/01/98/360_F_118019822_6CKXP6rXmVhDOzbXZlLqEM2ya4HhYzSV.jpg"
                              : "http://xn--temizliimnet-jyb.com/mate4game/images/" +
                                  snapshot.data[index].uyeProfil),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  title: Text(snapshot.data[index].uyeAd +
                      " " +
                      snapshot.data[index].uyeSoyad),
                  subtitle: Text(
                      "Gönderi Sayısı : " + snapshot.data[index].gonderiSayisi),
                  trailing: Icon(Icons.mail),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}

ListTile kisilerCard() {
  return ListTile(
    leading: Column(
      children: [
        CircleAvatar(
          radius: 28.0,
          backgroundImage: NetworkImage(
              'https://img-s2.onedio.com/id-52cdabd74588e27216000051/rev-0/w-900/h-770/f-jpg/s-c84acb9a3f9624ad06be20e2c52ccad5cb07b096.jpg'),
          backgroundColor: Colors.transparent,
        ),
        /* Text(
                      "ad soyad $index",
                      style: TextStyle(fontSize: 12),
                    ),*/
      ],
    ),
    title: Text("Adı Soyadı"),
    subtitle: Text("Gönderi Sayısı : 0"),
    trailing: Icon(Icons.mail),
  );
}

ListTile oyunlarCard() {
  return ListTile(
    leading: Column(
      children: [
        CircleAvatar(
          radius: 28.0,
          backgroundImage: NetworkImage(
              'https://i4.hurimg.com/i/hurriyet/75/750x422/5d1073d267b0a90454f5e355.jpg'),
          backgroundColor: Colors.transparent,
        ),
        /* Text(
                      "ad soyad $index",
                      style: TextStyle(fontSize: 12),
                    ),*/
      ],
    ),
    title: Text("Oyunun Adı"),
    subtitle: Text("İlgili Gönderi : 0"),
  );
}

ListTile kisioyunCard() {
  kisilerCard();
  return oyunlarCard();
}
