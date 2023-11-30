import 'dart:convert';

List<Word> bookFromJson(String str) =>
    List<Word>.from(json.decode(str).map((x) => Word.fromJson(x)));
String bookToJson(List<Word> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Word {
  final String id;
  final String icerik;
  final String sorusu;
  final int v;

  Word({
    required this.id,
    required this.icerik,
    required this.sorusu,
    required this.v,
  });
  factory Word.fromJson(Map<String, dynamic> json) => Word(
        id: json["_id"],
        icerik: json["icerik"],
        sorusu: json["sorusu"],
        v: json["__v"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "icerik": icerik,
        "sorusu": sorusu,
        "v": v,
      };
  Word.fromMap(Map<String, dynamic> map)
      : id = map["_id"],
        icerik = map["icerik"],
        sorusu = map["sorusu"],
        v = map["__v"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "icerik": icerik,
      "sorusu": sorusu,
      "v": v,
    };
  }

  @override
  String toString() {
    return "Word {id: $id, sorusu: $sorusu, icerik: $icerik, v: $v";
  }
}
