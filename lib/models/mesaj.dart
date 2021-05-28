import 'package:cloud_firestore/cloud_firestore.dart';

class Mesaj {
  final String Alici;
  final String Gonderici;
  final String mesaj;
  final Timestamp Date;

  Mesaj({this.Alici, this.Gonderici, this.mesaj, this.Date});

  Map<String, dynamic> toMap() {
    return {
      'alici': Alici,
      'gonderici': Gonderici,
      'mesaj': mesaj,
      'Date': Date
    };
  }

  Mesaj.fromMap(Map<String, dynamic> map)
      : Alici = map['Alici'],
        Gonderici = map['Gonderici'],
        mesaj = map['Mesaj'],
        Date = map['Date'];

  @override
  String toString() {
    return 'Mesaj{alici: $Alici, gönderici: $Gonderici, mesaj: $mesaj, date: $Date}';
  }
}
