class kisilerArama {
  String id;
  String uyeAd;
  String uyeSoyad;
  String uyeMail;
  String uyeSifre;
  String uyeAktif;
  String uyeOzelId;
  String uyeProfil;
  String gonderiSayisi;

  kisilerArama(
      {this.id,
      this.uyeAd,
      this.uyeSoyad,
      this.uyeMail,
      this.uyeSifre,
      this.uyeAktif,
      this.uyeOzelId,
      this.uyeProfil,
      this.gonderiSayisi});

  kisilerArama.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    uyeAd = json['uyeAd'];
    uyeSoyad = json['uyeSoyad'];
    uyeMail = json['uyeMail'];
    uyeSifre = json['uyeSifre'];
    uyeAktif = json['uyeAktif'];
    uyeOzelId = json['uyeOzelId'];
    uyeProfil = json['uyeProfil'];
    gonderiSayisi = json['GonderiSayisi'];
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
    data['GonderiSayisi'] = this.gonderiSayisi;
    return data;
  }
}
