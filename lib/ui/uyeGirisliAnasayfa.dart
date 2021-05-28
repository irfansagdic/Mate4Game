import 'package:flutter/material.dart';
import 'package:mate4game/ui/arama.dart';
import 'package:mate4game/ui/gonderiEkle.dart';
import 'package:mate4game/ui/paylasimlar.dart';
import 'package:mate4game/ui/profilpage.dart';
import 'package:mate4game/ui/uyeGirisliAppBar.dart';
import 'package:mate4game/widgets/custom_app_bar.dart';

class uyeGirisliPaylasimlar extends StatefulWidget {
  final int gelenSayfaNo;

  const uyeGirisliPaylasimlar({Key key, this.gelenSayfaNo}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return uyeGirisliPaylasimlarState();
  }
}

class uyeGirisliPaylasimlarState extends State<uyeGirisliPaylasimlar> {
  var _selectedPage = 0;

  List<Widget> tumSayfalar = [
    Gonderiler(),
    aramaSayfasi(), //userprofilpage
    gonderiEkle(),
    ProfilPage(),
  ];
  onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  int iGirdiMi = 0;
  @override
  // TODO: implement widget

  @override
  Widget build(BuildContext context) {
    if (widget.gelenSayfaNo != null && iGirdiMi == 0) {
      iGirdiMi = 1;
      setState(() {
        _selectedPage = widget.gelenSayfaNo;
      });
    }

    return Scaffold(
        appBar: uyeGirisliAppBar(),
        //    body: Gonderiler(),
        body: tumSayfalar.elementAt(_selectedPage),
        bottomNavigationBar: CustomBottomAppBar(
          page: _selectedPage,
          press: onItemTapped,
        ));
  }
}
