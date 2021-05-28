class oyun {
  String oyunId;
  String oyunAdi;

  oyun({this.oyunId, this.oyunAdi});

  oyun.fromJson(Map<String, dynamic> json) {
    oyunId = json['oyunId'];
    oyunAdi = json['oyunAdi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oyunId'] = this.oyunId;
    data['oyunAdi'] = this.oyunAdi;
    return data;
  }
}
