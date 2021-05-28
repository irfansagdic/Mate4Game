import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:mate4game/models/oyun.dart';
import 'package:mate4game/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class gonderiEkle extends StatefulWidget {
  @override
  _gonderiEkleState createState() => _gonderiEkleState();
}

class _gonderiEkleState extends State<gonderiEkle> {
  SharedPreferences mySharedPrefences;
  var value = "1";
  String sGonderi;
  TextEditingController textController1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController1 = TextEditingController();
    SharedPreferences.getInstance().then((sf) => mySharedPrefences = sf);
  }

  @override
  void dispose() {
    textController1.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          maxLines: 3,
          maxLength: 100,
          controller: textController1,
          decoration: InputDecoration(hintText: "Gönderinizi Yazınız"),
        ),
      ),
      Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: services.getOyun(),
          builder: (context, AsyncSnapshot<List<oyun>> snapshot) {
            if (snapshot.hasData) {
              return DropdownButton<String>(
                  isExpanded: true,
                  value: value == null ? snapshot.data[0].oyunId : value,
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                  items: snapshot.data
                      .map((fc) => DropdownMenuItem<String>(
                            child: Text(fc.oyunAdi),
                            value: fc.oyunId.toString(),
                          ))
                      .toList());
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      RaisedButton(
        onPressed: () {
          gonderiKayitFonk();
        },
        child: Text("Gönderiyi Paylaş"),
        color: Colors.blue,
        textColor: Colors.white,
      )
    ]);
  }

  void gonderiKayitFonk() async {
    String sMail = mySharedPrefences.getString("mail");
    sGonderi = textController1.text.toString();

    var result = await services.gonderiKayit(sGonderi, value, sMail);
    // var map = json.decode(result);
    print(result);
    if (result == "﻿gonderiBasarili") {
      return showDialog<void>(
        context: context,
        barrierDismissible:
            false, //this means the user must tap a button to exit the Alert Dialog
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bilgi Mesajı'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Gönderiniz Başarıyla Eklendi'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible:
            false, //this means the user must tap a button to exit the Alert Dialog
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hata Mesajı'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Saate 1 kere gönderi paylaşımı yapabilirsiniz"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
