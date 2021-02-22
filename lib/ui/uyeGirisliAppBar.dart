import 'package:flutter/material.dart';

class uyeGirisliAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Mate4Game",
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_forward_outlined,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
