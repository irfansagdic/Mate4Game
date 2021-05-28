import 'package:cloud_firestore/cloud_firestore.dart';

class tumSohbetlerr {
  final String SonMesaj;
  final String id_1;
  final String id_2;
  final Timestamp SonMesajTarih;

  tumSohbetlerr({this.SonMesaj, this.id_1, this.id_2, this.SonMesajTarih});

  Map<String, dynamic> toMap() {
    return {
      'SonMesaj': SonMesaj,
      'SonMesajTarih': SonMesajTarih,
      'id_1': id_1,
      'id_2': id_2
    };
  }

  tumSohbetlerr.fromMap(Map<String, dynamic> map)
      : SonMesaj = map['SonMesaj'],
        SonMesajTarih = map['SonMesajTarih'],
        id_1 = map['id_1'],
        id_2 = map['id_2'];
}
