class userProfil {
  String uyeAd;
  String uyeSoyad;
  String uyeMail;
  String uyeProfil;

  userProfil({this.uyeAd, this.uyeSoyad, this.uyeMail, this.uyeProfil});

  userProfil.fromJson(Map<String, dynamic> json) {
    uyeAd = json['uyeAd'];
    uyeSoyad = json['uyeSoyad'];
    uyeMail = json['uyeMail'];
    uyeProfil = json['uyeProfil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uyeAd'] = this.uyeAd;
    data['uyeSoyad'] = this.uyeSoyad;
    data['uyeMail'] = this.uyeMail;
    data['uyeProfil'] = this.uyeProfil;
    return data;
  }
}
