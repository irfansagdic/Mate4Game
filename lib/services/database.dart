import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mate4game/models/aramaHepsi.dart';
import 'package:mate4game/models/aramaOyunlarSart.dart';
import 'package:mate4game/models/gonderi.dart';
import 'package:mate4game/models/kisilerArama.dart';
import 'package:mate4game/models/oyun.dart';
import 'package:mate4game/models/oyunlarArama.dart';
import 'package:mate4game/models/tumGonderiler.dart';
import 'package:mate4game/models/tumSohbetlerJson.dart';
import 'package:mate4game/models/user.dart';
import 'package:mate4game/models/userProfil.dart';

class services {
  static Future<String> getAliciToken(String sMail) async {
    var map = Map<String, dynamic>();
    map["islem"] = "getToken";
    map["mail"] = sMail;
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/getToken.php",
        body: map);

    if (response.statusCode == 200) {
      return response.body.toString().trim();
    }
  }

  static Future<List<tumSohbetlerJson>> ozelIdleriGetir(String sMail) async {
    var map = Map<String, dynamic>();
    map["islem"] = "ozelidler";
    map["mail"] = sMail;
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/getOzelidler.php",
        body: map);

    if (response.statusCode == 200) {
      List<tumSohbetlerJson> result = parseResponseTumSohbetler(response.body);

      return result;
    }
  }

  static List<tumSohbetlerJson> parseResponseTumSohbetler(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<tumSohbetlerJson>((json) => tumSohbetlerJson.fromJson(json))
        .toList();
  }

  static Future<userProfil> userProfili(int iUserId) async {
    var map = Map<String, dynamic>();
    map["islem"] = "userProfilPage";
    map["uyeid"] = iUserId.toString();

    try {
      var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/getProfilUser.php",
        body: map,
      );

      if (response.statusCode == 200) {
        final jsonresponse = json.decode(response.body);

        var uye = userProfil.fromJson(jsonresponse[0]);
        return uye;
      }
    } catch (e) {
      print("Hata:" + e.toString());
    }
  }

  static Future<List<aramaHepsi>> aramaHepsii(String sKelime) async {
    var map = Map<String, dynamic>();
    map["islem"] = "arama";
    map["kelime"] = sKelime;
    map["filtre"] = "hepsi";
    var response = await http
        .post("http://xn--temizliimnet-jyb.com/mate4game/arama.php", body: map);

    if (response.statusCode == 200) {
      List<aramaHepsi> result = parseResponseAramaHepsi(response.body);

      return result;
    }
  }

  static List<aramaHepsi> parseResponseAramaHepsi(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<aramaHepsi>((json) => aramaHepsi.fromJson(json)).toList();
  }

  static Future<List<aramaOyunlarSart>> aramaOyunlarrSart(int iOyunId) async {
    var map = Map<String, dynamic>();
    map["islem"] = "aramaoyunsart";
    map["oyunid"] = iOyunId.toString();
    var response = await http
        .post("http://xn--temizliimnet-jyb.com/mate4game/arama.php", body: map);

    if (response.statusCode == 200) {
      List<aramaOyunlarSart> result =
          parseResponseAramaOyunlarSart(response.body);

      return result;
    }
  }

  static List<aramaOyunlarSart> parseResponseAramaOyunlarSart(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<aramaOyunlarSart>((json) => aramaOyunlarSart.fromJson(json))
        .toList();
  }

  static Future<List<aramaOyunlar>> aramaOyunlarr(
      String sKelime, String sFiltre) async {
    var map = Map<String, dynamic>();
    map["islem"] = "arama";
    map["kelime"] = sKelime;
    map["filtre"] = sFiltre;
    var response = await http
        .post("http://xn--temizliimnet-jyb.com/mate4game/arama.php", body: map);

    if (response.statusCode == 200) {
      List<aramaOyunlar> result = parseResponseAramaOyunlar(response.body);

      return result;
    }
  }

  static List<aramaOyunlar> parseResponseAramaOyunlar(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<aramaOyunlar>((json) => aramaOyunlar.fromJson(json))
        .toList();
  }

  static Future<List<kisilerArama>> aramaKisiler(
      String sKelime, String sFiltre) async {
    var map = Map<String, dynamic>();
    map["islem"] = "arama";
    map["kelime"] = sKelime;
    map["filtre"] = sFiltre;
    var response = await http
        .post("http://xn--temizliimnet-jyb.com/mate4game/arama.php", body: map);

    if (response.statusCode == 200) {
      List<kisilerArama> result = parseResponseAramaKisiler(response.body);

      return result;
    }
  }

  static List<kisilerArama> parseResponseAramaKisiler(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<kisilerArama>((json) => kisilerArama.fromJson(json))
        .toList();
  }

  static Future<List<gonderilerim>> getGonderilerim(String mail) async {
    var map = Map<String, dynamic>();
    map["islem"] = "getgonderilerim";
    map["mail"] = mail;
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/getGonderilerim.php",
        body: map);

    if (response.statusCode == 200) {
      List<gonderilerim> result = parseResponseGonderi(response.body);

      return result;
    }
  }

  static List<gonderilerim> parseResponseGonderi(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<gonderilerim>((json) => gonderilerim.fromJson(json))
        .toList();
  }

  static Future<List<tumGonderiler>> getTumGonderilerim() async {
    var map = Map<String, dynamic>();
    map["islem"] = "gettumgonderilerim";

    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/getTumGonderilerim.php",
        body: map);

    if (response.statusCode == 200) {
      List<tumGonderiler> result = parseResponseTumGonderi(response.body);

      return result;
    }
  }

  static List<tumGonderiler> parseResponseTumGonderi(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<tumGonderiler>((json) => tumGonderiler.fromJson(json))
        .toList();
  }

  static Future<String> gonderiGuncelle(
      String gonderi, String oyunKategori, String iGonderiIdd) async {
    var map = Map<String, dynamic>();
    map["gonderi"] = gonderi;
    map["oyunKategori"] = oyunKategori;
    map["iGonderiIdd"] = iGonderiIdd;

    map["islem"] = "gonderiguncelle";
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/veritabaniIslemleri.php",
        body: map);

    if (response.statusCode == 200) {
      return response.body.toString().trim();
    }
  }

  static Future<String> OzelIdGetir(
      String AliciMail, String GondericiMail) async {
    var map = Map<String, dynamic>();
    map["alici"] = AliciMail;
    map["gonderici"] = GondericiMail;

    map["islem"] = "ozelid";
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/veritabaniIslemleri.php",
        body: map);

    if (response.statusCode == 200) {
      return response.body.toString();
    }
  }

  static Future<String> uyeBilgileriGuncelle(
      String ad, String soyad, String mail, String sifre) async {
    var map = Map<String, dynamic>();
    map["ad"] = ad;
    map["soyad"] = soyad;
    map["mail"] = mail;
    map["sifre"] = sifre;
    map["islem"] = "uyeguncelleme";
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/veritabaniIslemleri.php",
        body: map);

    if (response.statusCode == 200) {
      return response.body.toString().trim();
    }
  }

  static Future<String> profilResmi(var resim, String mail) async {
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/veritabaniIslemleri.php",
        body: {'image': resim, 'islem': "profilresmiguncelle", 'mail': mail});
    if (response.statusCode == 200) {
      return response.body.toString().trim();
    }
  }

  static Future<String> gonderiKayit(
      String gonderi, String oyunId, String Mail) async {
    var map = Map<String, dynamic>();
    map["gonderi"] = gonderi;
    map["oyunId"] = oyunId;
    map["Mail"] = Mail;
    map["islem"] = "gonderiKayit";
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/veritabaniIslemleri.php",
        body: map);

    if (response.statusCode == 200) {
      return response.body;
    }
  }

  static Future<List<oyun>> getOyun() async {
    var map = Map<String, dynamic>();
    map["islem"] = "getoyun";
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/getOyun.php",
        body: map);

    if (response.statusCode == 200) {
      List<oyun> result = parseResponse(response.body);

      return result;
    }
  }

  static List<oyun> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<oyun>((json) => oyun.fromJson(json)).toList();
  }

  static Future<String> uyeGiris(
      String mail, String sifre, String sToken) async {
    var map = Map<String, dynamic>();
    map["email"] = mail;
    map["sifre"] = sifre;
    map["token"] = sToken;
    map["islem"] = "uyeGiris";
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/veritabaniIslemleri.php",
        body: map);

    if (response.statusCode == 200) {
      return response.body.toString().trim();
    }
  }

  static Future<String> mailKontrol(String mail) async {
    var map = Map<String, dynamic>();
    map["email"] = mail;
    map["islem"] = "MailKontrol";
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/veritabaniIslemleri.php",
        body: map);

    if (response.statusCode == 200) {
      return response.body.toString().trim();
    }
  }

  static Future<String> gonderSil(String gonderiId) async {
    var map = Map<String, dynamic>();
    map["gonderId"] = gonderiId;
    map["islem"] = "gonderisil";
    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/veritabaniIslemleri.php",
        body: map);

    if (response.statusCode == 200) {
      return response.body.trim().toString();
    }
  }

  static Future<user> getUser() async {
    try {
      var response =
          await http.get("http://xn--temizliimnet-jyb.com/mate4game/a.php");
      if (response.statusCode == 200) {
        //var uye = user.fromJson(json.decode(response.body));
        final jsonresponse = json.decode(response.body);
        var uye = user.fromJson(jsonresponse[1]);
        return uye;
      }
    } catch (e) {
      print("Hata=" + e.toString());
    }
  }

  static Future<String> uyeKayit(String uyeAd, String uyeSoyad, String uyeEmail,
      String uyeSifre, String sToken) async {
    var map = Map<String, dynamic>();
    map["adi"] = uyeAd;
    map["token"] = sToken;
    map["soyadi"] = uyeSoyad;
    map["email"] = uyeEmail;
    map["sifre"] = uyeSifre;
    map["islem"] = "uyekayit";

    var response = await http.post(
        "http://xn--temizliimnet-jyb.com/mate4game/veritabaniIslemleri.php",
        body: map);

    if (response.statusCode == 200) {
      return response.body;
    }
  }
}
