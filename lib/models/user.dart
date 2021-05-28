class user {
  String id;
  String uyeAd;
  String uyeSoyad;
  String uyeMail;
  String uyeSifre;

  user({this.id, this.uyeAd, this.uyeSoyad, this.uyeMail, this.uyeSifre});

  user.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    uyeAd = json['uyeAd'];
    uyeSoyad = json['uyeSoyad'];
    uyeMail = json['uyeMail'];
    uyeSifre = json['uyeSifre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['uyeAd'] = this.uyeAd;
    data['uyeSoyad'] = this.uyeSoyad;
    data['uyeMail'] = this.uyeMail;
    data['uyeSifre'] = this.uyeSifre;
    return data;
  }
}
