import 'package:flutter/material.dart';

class Gonderiler extends StatefulWidget {
  @override
  GonderilerState createState() => GonderilerState();
}

class GonderilerState extends State<Gonderiler> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
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
                  backgroundImage: NetworkImage(
                      'https://img-s2.onedio.com/id-52cdabd74588e27216000051/rev-0/w-900/h-770/f-jpg/s-c84acb9a3f9624ad06be20e2c52ccad5cb07b096.jpg'),
                  backgroundColor: Colors.transparent,
                ),
                Text(
                  "ad soyad $index",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            title: Text("Oyunun Adı $index"),
            subtitle: Text("İlanın Açıklaması $index"),
            trailing: Icon(Icons.mail),
          ),
        );
      },
    );
  }
}
