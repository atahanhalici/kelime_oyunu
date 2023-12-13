import 'package:hive_flutter/hive_flutter.dart';

class LocalDbService {
  misafirGiris() async {
    Map veriler = {};
    var box = await Hive.openBox("user");
    if (box.get("puan") != null) {
      veriler.addAll({"puan": box.get("puan")});
      veriler.addAll({"sonsoru": box.get("sonsoru")});
      return veriler;
    } else {
      await box.put("puan", 0);
      await box.put("sonsoru", 0);
      veriler.addAll({"puan": 0});
      veriler.addAll({"sonsoru": 0});
      return veriler;
    }
  }

  Future<String> beniHatirlaKontrol() async {
    var box = await Hive.openBox("user");
    if (box.get("id") != null) {
      return box.get("id");
    } else {
      return "0";
    }
  }

  cikisYap() async {
    var box = await Hive.openBox("user");
    box.clear();
  }

  misafirPuanEkle(int puan) async {
    var box = await Hive.openBox("user");
    var puani = box.get("puan");
    var sonSoru = box.get("sonsoru");
    puani = puani + puan;
    sonSoru++;
    await box.put("puan", puani);
    await box.put("sonsoru", sonSoru);
    return {"puan": puani, "sonsoru": sonSoru};
  }
}
