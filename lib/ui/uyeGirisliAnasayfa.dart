import 'package:flutter/material.dart';

import 'paylasimlar.dart';
import 'uyeGirisliAppBar.dart';

class uyeGirisliPaylasimlar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return uyeGirisliPaylasimlarState();
  }
}

class uyeGirisliPaylasimlarState extends State<uyeGirisliPaylasimlar> {
  List<Paylasim> tumPaylasimlar = [];
  int secilenMenuItem = 0;
  /*List<Widget> tumSayfalar;
  aramaSayfasi AramaSayfasi = new aramaSayfasi();*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  tumSayfalar=[];
  }

  @override
  Widget build(BuildContext context) {
    tumPaylasimlariGetir();
    return Scaffold(
      appBar: uyeGirisliAppBar(),
      //    body: Gonderiler(),
      body: Gonderiler(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Anasayfa")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Arama")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_sharp), title: Text("Gönderi Ekle")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp), title: Text("Profil")),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: secilenMenuItem,
        onTap: (index) {
          setState(() {
            secilenMenuItem = index;
          });
        },
      ),
    );
  }

  void tumPaylasimlariGetir() {
    tumPaylasimlar = List.generate(
        100,
        (index) => Paylasim(
            "Adı = Adı $index",
            "Soyadı = Soyadı $index",
            "Oyunun Adı = Oyun Ad $index",
            "Paylaşım Açıklama=açıklama $index"));
  }
}

class Paylasim {
  String _ad;
  String _soyad;
  String _oyununAdi;
  String _paylasimAciklama;

  Paylasim(this._ad, this._soyad, this._oyununAdi, this._paylasimAciklama);
}
