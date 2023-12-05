import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kelime_oyunu/locators.dart';
import 'package:kelime_oyunu/models/word.dart';
import 'package:kelime_oyunu/repository/repository.dart';

enum ViewState { geliyor, geldi, hata }

class SingleViewModel with ChangeNotifier {
  final Repository _repository = locator<Repository>();
  ViewState _state = ViewState.geliyor;
  ViewState get state => _state;
  List aciklar = [];
  Map<int, String> tahmin = {};
  List<Word> kelimeler = [];
  String soru = "";
  bool kontrolSurec = false;
  Map<int, String> ipucu = {
    0: "w",
    1: "o",
    2: "r",
    3: "d",
    4: " ",
    5: "w",
    6: "a",
    7: "r",
    8: "s",
  };
  bool bitti = false;
  Color renk = Colors.black;
  bool puanEkle = false;
  int sPuan = 0;
  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  int randomSayi(Map ipucu, List aciklar) {
    Random random = Random();
    int randomNumber;

    do {
      randomNumber = random.nextInt(ipucu.length);
    } while (aciklar.contains(randomNumber) ||
        tahmin.keys.toList().contains(randomNumber));
    notifyListeners();
    return randomNumber;
  }

  kontrol(int sonsoru) async {
    puanEkle = false;
    kontrolSurec = true;
    notifyListeners();
    bool areEqual = true;
    List<MapEntry<int, String>> sortedEntries = tahmin.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    List<MapEntry<int, String>> sortedEntries2 = ipucu.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    print(sortedEntries);
    print(sortedEntries2);
    if (sortedEntries.length == sortedEntries2.length) {
      for (int i = 0; i < sortedEntries.length; i++) {
        if (sortedEntries[i].key != sortedEntries2[i].key ||
            sortedEntries[i].value != sortedEntries2[i].value) {
          areEqual = false;
          break;
        }
      }
      print(sortedEntries);
      print(sortedEntries2);
    } else {
      areEqual = false;
    }

    if (areEqual) {
      renk = Colors.green;
      puanEkle = true;
      sifirla();
      await Future.delayed(const Duration(seconds: 1));
    } else {
      renk = Colors.red;
      sifirla();
    }
    kontrolSurec = false;
    sPuan = (ipucu.length - aciklar.length) * 100;
    notifyListeners();
  }

  void renkSifirla() {
    renk = Colors.black;
    notifyListeners();
  }

  void sifirla() async {
    await Future.delayed(const Duration(seconds: 1));
    tahmin.clear();
    renk = Colors.black;

    notifyListeners();
  }

  singleKelimeGetir(int sonsoru) async {
    state = ViewState.geliyor;
    kelimeler = await _repository.singleKelimeGetir();
    siradakiKelimeyiParcala(sonsoru);
  }

  siradakiKelimeyiParcala(int sonsoru) {
    print(kelimeler);
    print("ss" + sonsoru.toString());
    if (sonsoru >= kelimeler.length) {
      bitti = true;
    } else {
      state = ViewState.geliyor;
      ipucu.clear();
      aciklar.clear();
      tahmin.clear();
      String kelime = kelimeler[sonsoru].icerik.toLowerCase();
      List bolum = kelime.split("");
      for (int i = 0; i < bolum.length; i++) {
        ipucu.addAll({i: bolum[i]});
      }
      print(ipucu);
      soru = kelimeler[sonsoru].sorusu;
      print(soru);

      for (int i = 0; i < bolum.length; i++) {
        if (bolum[i].contains(' ')) {
          aciklar.add(i);
        }
      }
      sPuan = (ipucu.length - aciklar.length) * 100;
    }

    state = ViewState.geldi;
    notifyListeners();
  }

  void harfAl() {
    sPuan = sPuan - 100;
    notifyListeners();
  }
}
