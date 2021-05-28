class tumGonderiler {
  String id;
  String uyeAd;
  String uyeSoyad;
  String uyeMail;
  String uyeSifre;
  String uyeAktif;
  String uyeOzelId;
  String uyeProfil;
  String gonderi;
  String oyunId;
  String yil;
  String ay;
  String gun;
  String saat;
  String dakika;
  String email;
  String oyunAdi;

  tumGonderiler(
      {this.id,
      this.uyeAd,
      this.uyeSoyad,
      this.uyeMail,
      this.uyeSifre,
      this.uyeAktif,
      this.uyeOzelId,
      this.uyeProfil,
      this.gonderi,
      this.oyunId,
      this.yil,
      this.ay,
      this.gun,
      this.saat,
      this.dakika,
      this.email,
      this.oyunAdi});

  tumGonderiler.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    uyeAd = json['uyeAd'];
    uyeSoyad = json['uyeSoyad'];
    uyeMail = json['uyeMail'];
    uyeSifre = json['uyeSifre'];
    uyeAktif = json['uyeAktif'];
    uyeOzelId = json['uyeOzelId'];
    uyeProfil = json['uyeProfil'];
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
    data['uyeAd'] = this.uyeAd;
    data['uyeSoyad'] = this.uyeSoyad;
    data['uyeMail'] = this.uyeMail;
    data['uyeSifre'] = this.uyeSifre;
    data['uyeAktif'] = this.uyeAktif;
    data['uyeOzelId'] = this.uyeOzelId;
    data['uyeProfil'] = this.uyeProfil;
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
