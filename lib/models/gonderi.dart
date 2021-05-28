class gonderilerim {
  String id;
  String gonderi;
  String oyunId;
  String yil;
  String ay;
  String gun;
  String saat;
  String dakika;
  String email;
  String oyunAdi;

  gonderilerim(
      {this.id,
      this.gonderi,
      this.oyunId,
      this.yil,
      this.ay,
      this.gun,
      this.saat,
      this.dakika,
      this.email,
      this.oyunAdi});

  gonderilerim.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    gonderi = json['gonderi'];
    oyunId = json['oyunId'];
    yil = json['yil'];
    ay = json['ay'];
    gun = json['gun'];
    saat = json['saat'];
    dakika = json['dakika'];
    email = json['email'];
    oyunAdi = json['oyunAdi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['gonderi'] = this.gonderi;
    data['oyunId'] = this.oyunId;
    data['yil'] = this.yil;
    data['ay'] = this.ay;
    data['gun'] = this.gun;
    data['saat'] = this.saat;
    data['dakika'] = this.dakika;
    data['email'] = this.email;
    data['oyunAdi'] = this.oyunAdi;
    return data;
  }
}
