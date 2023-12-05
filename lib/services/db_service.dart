import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kelime_oyunu/models/user.dart';
import 'package:kelime_oyunu/models/word.dart';

class DbServices {
  String yol = "http://192.168.137.1:3000";
  /*"https://word-wars.onrender.com";*/
  List<Word> _words = [];
  singleKelimeGetir() async {
    try {
      print("geldim");
      final response = await http.get(Uri.parse("$yol/singlekelime"));
      List jsonResponse = json.decode(response.body);
      _words = jsonResponse.map((e) => Word.fromJson(e)).toList();
      print("gittim");
      print(_words);
      return _words;
    } catch (e) {
      List<Word> asd = [];
      asd.add(Word(id: "", icerik: "", sorusu: "", v: 0));
      return asd;
    }
  }

  userRegister(Map veriler) async {
    try {
      print("geldim");
      var response = await http.post(Uri.parse("$yol/kullaniciregister"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode(veriler));
      var jsonResponse = json.decode(response.body);

      return jsonResponse;
    } catch (e) {
      return {
        "code": 404,
        "response":
            "Sunucularımıza erişilemiyor, Lütfen internet bağlantınızı kontrol edin"
      };
    }
  }

  userLogin(Map veriler) async {
    try {
      print("geldim");
      var response = await http.post(Uri.parse("$yol/kullanicilogin"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode(veriler));
      print("hey");
      var jsonResponse = json.decode(response.body);

      User user = User.fromJson(jsonResponse["user"]);

      Map sonuc = {
        "code": jsonResponse["code"],
        "response": jsonResponse["response"],
        "user": user
      };
      return sonuc;
    } catch (e) {
      return {
        "code": 404,
        "response":
            "Sunucularımıza erişilemiyor, Lütfen internet bağlantınızı kontrol edin",
        "user": User(
            sonsoru: 0,
            onlinepuan: 0,
            puan: 0,
            avatar: "",
            emailAktif: false,
            id: "",
            email: "",
            kullaniciadi: "",
            sifre: "",
            v: 0)
      };
    }
  }

  userGuncelle(Map veriler) async {
    try {
      print("geldim");
      print(veriler["id"]);
      var response = await http.post(Uri.parse("$yol/kullaniciguncelle"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode(veriler));
      var jsonResponse = json.decode(response.body);
      print("ben");
      User user = User.fromJson(jsonResponse["user"]);
      Map sonuc = {
        "code": jsonResponse["code"],
        "response": jsonResponse["response"],
        "user": user
      };
      print("burda");
      return sonuc;
    } catch (e) {
      return {
        "code": 404,
        "response":
            "Sunucularımıza erişilemiyor, Lütfen internet bağlantınızı kontrol edin",
        "user": User(
            sonsoru: 0,
            onlinepuan: 0,
            puan: 0,
            avatar: "",
            emailAktif: false,
            id: "",
            email: "",
            kullaniciadi: "",
            sifre: "",
            v: 0),
      };
    }
  }

  userGetir(String id) async {
    Map veri = {"id": id};
    var response = await http.post(Uri.parse("$yol/kullanici"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        body: jsonEncode(veri));
    var jsonResponse = json.decode(response.body);
    User user = User.fromJson(jsonResponse["user"]);

    Map sonuc = {
      "code": jsonResponse["code"],
      "response": jsonResponse["response"],
      "user": user
    };
    return sonuc;
  }

  sifreYenile(String eski, String yeni, String id) async {
    try {
      print("sa");
      Map veriler = {"id": id, "eskisifre": eski, "yenisifre": yeni};

      var response = await http.post(Uri.parse("$yol/kullanicisifredegistir"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode(veriler));
      print("as");
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print("ben");
      User user = User.fromJson(jsonResponse["user"]);
      Map sonuc = {
        "code": jsonResponse["code"],
        "response": jsonResponse["response"],
        "user": user
      };
      print("burda");
      return sonuc;
    } catch (e) {
      return {
        "code": 404,
        "response":
            "Sunucularımıza erişilemiyor, Lütfen internet bağlantınızı kontrol edin",
        "user": User(
            sonsoru: 0,
            onlinepuan: 0,
            puan: 0,
            avatar: "",
            emailAktif: false,
            id: "",
            email: "",
            kullaniciadi: "",
            sifre: "",
            v: 0),
      };
    }
  }

  puanEkle(String id, int puan) async {
    try {
      print("sa");
      Map veriler = {"id": id, "puan": puan};
      var response = await http.post(Uri.parse("$yol/kullanicipuan"),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode(veriler));
      print("as");
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print("ben");
      User user = User.fromJson(jsonResponse["user"]);
      Map sonuc = {
        "code": jsonResponse["code"],
        "response": jsonResponse["response"],
        "user": user
      };
      print("burda");
      return sonuc;
    } catch (e) {
      return {
        "code": 404,
        "response":
            "Sunucularımıza erişilemiyor, Lütfen internet bağlantınızı kontrol edin",
        "user": User(
            sonsoru: 0,
            onlinepuan: 0,
            puan: 0,
            avatar: "",
            emailAktif: false,
            id: "",
            email: "",
            kullaniciadi: "",
            sifre: "",
            v: 0),
      };
    }
  }
}
