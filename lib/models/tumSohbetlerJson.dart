class tumSohbetlerJson {
  String ozelId;
  String mesajiAlan;
  String uyeAd;
  String uyeSoyad;
  String resim;

  tumSohbetlerJson(
      {this.ozelId, this.mesajiAlan, this.uyeAd, this.uyeSoyad, this.resim});

  tumSohbetlerJson.fromJson(Map<String, dynamic> json) {
    ozelId = json['OzelId'];
    mesajiAlan = json['MesajiAlan'];
    uyeAd = json['uyeAd'];
    uyeSoyad = json['uyeSoyad'];
    resim = json['Resim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OzelId'] = this.ozelId;
    data['MesajiAlan'] = this.mesajiAlan;
    data['uyeAd'] = this.uyeAd;
    data['uyeSoyad'] = this.uyeSoyad;
    data['Resim'] = this.resim;
    return data;
  }
}
