import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int page;
  final Function press;

  const CustomBottomAppBar({Key key, this.page, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home), title: Text("Anasayfa")),
        BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("Arama")),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_sharp), title: Text("Gönderi Ekle")),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp), title: Text("Profil")),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: page,
      onTap: press,
    );
  }
}
