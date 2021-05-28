import 'package:flutter/material.dart';

import 'paylasimlar.dart';
import 'uyeGirissizAppBar.dart';

class Paylasimlar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PaylasimlarState();
  }
}

class PaylasimlarState extends State<Paylasimlar> {
  // List<Paylasim> tumPaylasimlar = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: uyeGirissizAppBar(),
      body: Gonderiler(),
    );
  }

  /*void tumPaylasimlariGetir() {
    tumPaylasimlar = List.generate(
        100,
        (index) => Paylasim(
            "Adı = Adı $index",
            "Soyadı = Soyadı $index",
            "Oyunun Adı = Oyun Ad $index",
            "Paylaşım Açıklama=açıklama $index"));
  }*/
}

/*class Paylasim {
  String _ad;
  String _soyad;
  String _oyununAdi;
  String _paylasimAciklama;
  Paylasim(this._ad, this._soyad, this._oyununAdi, this._paylasimAciklama);
}*/
