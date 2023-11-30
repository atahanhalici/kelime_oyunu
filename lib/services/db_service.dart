import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kelime_oyunu/models/word.dart';

class DbServices {
  String yol = "http://192.168.137.132:3000";
  List<Word> _words = [];
  singleKelimeGetir() async {
    try {
      print("geldim");
      final response = await http.get(Uri.parse("$yol/singlekelime"));
      List jsonResponse = json.decode(response.body);
      // ignore: unnecessary_type_check
      print("burdayim");
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
}
