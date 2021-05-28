import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mate4game/ui/uyeGirissizAnasayfa.dart';
import 'package:shared_preferences/shared_preferences.dart';

class uyeGirisliAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Mate4Game",
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/tumSohbetler");
          },
          child: IconButton(
            icon: Icon(
              Icons.messenger,
              color: Colors.white,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            return showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Çıkış Yap'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: const <Widget>[
                        Text('Çıkmak İstediğinizden Emin Misiniz?'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Evet'),
                      onPressed: () {
                        sharedpresil();
                        Get.offAll(Paylasimlar());
                      },
                    ),
                    TextButton(
                      child: const Text('Hayır'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);

  sharedpresil() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
