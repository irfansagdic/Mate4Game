class aramaOyunlarSart {
  String oyunId;
  String oyunAdi;
  String oyunResim;
  String id;
  String gonderi;
  String yil;
  String ay;
  String gun;
  String saat;
  String dakika;
  String email;
  String uyeAd;
  String uyeSoyad;
  String uyeMail;
  String uyeSifre;
  String uyeAktif;
  String uyeOzelId;
  String uyeProfil;

  aramaOyunlarSart(
      {this.oyunId,
      this.oyunAdi,
      this.oyunResim,
      this.id,
      this.gonderi,
      this.yil,
      this.ay,
      this.gun,
      this.saat,
      this.dakika,
      this.email,
      this.uyeAd,
      this.uyeSoyad,
      this.uyeMail,
      this.uyeSifre,
      this.uyeAktif,
      this.uyeOzelId,
      this.uyeProfil});

  aramaOyunlarSart.fromJson(Map<String, dynamic> json) {
    oyunId = json['oyunId'];
    oyunAdi = json['oyunAdi'];
    oyunResim = json['oyunResim'];
    id = json['Id'];
    gonderi = json['gonderi'];
    yil = json['yil'];
    ay = json['ay'];
    gun = json['gun'];
    saat = json['saat'];
    dakika = json['dakika'];
    email = json['email'];
    uyeAd = json['uyeAd'];
    uyeSoyad = json['uyeSoyad'];
    uyeMail = json['uyeMail'];
    uyeSifre = json['uyeSifre'];
    uyeAktif = json['uyeAktif'];
    uyeOzelId = json['uyeOzelId'];
    uyeProfil = json['uyeProfil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oyunId'] = this.oyunId;
    data['oyunAdi'] = this.oyunAdi;
    data['oyunResim'] = this.oyunResim;
    data['Id'] = this.id;
    data['gonderi'] = this.gonderi;
    data['yil'] = this.yil;
    data['ay'] = this.ay;
    data['gun'] = this.gun;
    data['saat'] = this.saat;
    data['dakika'] = this.dakika;
    data['email'] = this.email;
    data['uyeAd'] = this.uyeAd;
    data['uyeSoyad'] = this.uyeSoyad;
    data['uyeMail'] = this.uyeMail;
    data['uyeSifre'] = this.uyeSifre;
    data['uyeAktif'] = this.uyeAktif;
    data['uyeOzelId'] = this.uyeOzelId;
    data['uyeProfil'] = this.uyeProfil;
    return data;
  }
}
