class aramaOyunlar {
  String oyunId;
  String oyunAdi;
  String oyunResim;
  String gonderiSayisi;

  aramaOyunlar({this.oyunId, this.oyunAdi, this.oyunResim, this.gonderiSayisi});

  aramaOyunlar.fromJson(Map<String, dynamic> json) {
    oyunId = json['oyunId'];
    oyunAdi = json['oyunAdi'];
    oyunResim = json['oyunResim'];
    gonderiSayisi = json['GonderiSayisi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oyunId'] = this.oyunId;
    data['oyunAdi'] = this.oyunAdi;
    data['oyunResim'] = this.oyunResim;
    data['GonderiSayisi'] = this.gonderiSayisi;
    return data;
  }
}
