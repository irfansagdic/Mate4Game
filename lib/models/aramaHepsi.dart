class aramaHepsi {
  String ad;
  String soyad;
  String id;
  String resim;
  String gonderiSayisi;

  aramaHepsi({this.ad, this.soyad, this.id, this.resim, this.gonderiSayisi});

  aramaHepsi.fromJson(Map<String, dynamic> json) {
    ad = json['Ad'];
    soyad = json['Soyad'];
    id = json['Id'];
    resim = json['Resim'];
    gonderiSayisi = json['GonderiSayisi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Ad'] = this.ad;
    data['Soyad'] = this.soyad;
    data['Id'] = this.id;
    data['Resim'] = this.resim;
    data['GonderiSayisi'] = this.gonderiSayisi;
    return data;
  }
}
