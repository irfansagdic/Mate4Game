import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mate4game/ui/uyeGirisliAppBar.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool kullaniciadiControl = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: uyeGirisliAppBar(),
      drawer: Drawer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: CircleAvatar(
              child: Image.network(
                  "https://www.aydemirlergergitavan.com/wp-content/uploads/2019/05/yuvarlak-7.jpg"),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              children: [
                Row(
                  children: [
                    !kullaniciadiControl
                        ? Text("Kullanıcı Adı")
                        : TextField(
                            autofocus: true,
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          kullaniciadiControl = true;
                        });
                      },
                    ),
                  ],
                ),
                Text("Kullanıcı Adı"),
                Text("Kullanıcı Adı"),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: RaisedButton(
              child: Text("KAYDET"),
              onPressed: () {},
            ),
          ),
        ],
      )),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, i) {
          return ListTile(
            leading: CircleAvatar(),
            title: Text("GönderdiAdı"),
            trailing: Column(
              children: [Icon(Icons.edit), Icon(Icons.delete)],
            ),
          );
        },
      ),
    );
  }
}
