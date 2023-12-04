import 'dart:convert';

List<User> bookFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
String bookToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  final int sonsoru;
  final int onlinepuan;
  final int puan;
  final String avatar;
  final bool emailAktif;
  final String id;
  final String email;
  final String kullaniciadi;
  final String sifre;
  final int v;

  User({
    required this.sonsoru,
    required this.onlinepuan,
    required this.puan,
    required this.avatar,
    required this.emailAktif,
    required this.id,
    required this.email,
    required this.kullaniciadi,
    required this.sifre,
    required this.v,
  });
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        sonsoru: json["sonsoru"],
        onlinepuan: json["onlinepuan"],
        puan: json["puan"],
        avatar: json["avatar"],
        emailAktif: json["emailAktif"],
        email: json["email"],
        kullaniciadi: json["kullaniciadi"],
        sifre: json["sifre"],
        v: json["__v"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "sonsoru": sonsoru,
        "onlinepuan": onlinepuan,
        "puan": puan,
        "avatar": avatar,
        "emailAktif": emailAktif,
        "email": email,
        "kullaniciadi": kullaniciadi,
        "sifre": sifre,
        "v": v,
      };
  User.fromMap(Map<String, dynamic> map)
      : id = map["_id"],
        sonsoru = map["sonsoru"],
        onlinepuan = map["onlinepuan"],
        puan = map["puan"],
        avatar = map["avatar"],
        emailAktif = map["emailAktif"],
        email = map["email"],
        kullaniciadi = map["kullaniciadi"],
        sifre = map["sifre"],
        v = map["__v"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "sonsoru": sonsoru,
      "onlinepuan": onlinepuan,
      "puan": puan,
      "avatar": avatar,
      "emailAktif": emailAktif,
      "email": email,
      "kullaniciadi": kullaniciadi,
      "sifre": sifre,
      "v": v,
    };
  }

  @override
  String toString() {
    return "User {id: $id, sonsoru: $sonsoru, onlinepuan: $onlinepuan,puan: $puan, avatar: $avatar, emailAktif: $emailAktif, email: $email, kullaniciadi: $kullaniciadi, sifre: $sifre,  v: $v}";
  }
}
