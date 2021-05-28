import 'package:flutter/material.dart';

class uyeGirissizAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Mate4Game",
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/uyeKayit");
          },
        ),
        IconButton(
          icon: Icon(
            Icons.login,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/uyeGiris");
          },
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
