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
  int sira = 0;
  String soru = "";
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

  Color renk = Colors.black;
  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  int randomSayi(Map ipucu, List aciklar) {
    Random random = Random();
    int randomNumber;

    do {
      randomNumber = random.nextInt(ipucu.length);
    } while (aciklar.contains(randomNumber));
    notifyListeners();
    return randomNumber;
  }

  kontrol() async {
    bool areEqual = true;
    List<MapEntry<int, String>> sortedEntries = tahmin.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    List<MapEntry<int, String>> sortedEntries2 = ipucu.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    if (sortedEntries.length == sortedEntries2.length) {
      for (int i = 0; i < sortedEntries.length; i++) {
        if (sortedEntries[i].key != sortedEntries2[i].key ||
            sortedEntries[i].value != sortedEntries2[i].value) {
          areEqual = false;
          break;
        }
      }
    } else {
      areEqual = false;
    }

    if (areEqual) {
      renk = Colors.green;
      sifirla();
      await Future.delayed(const Duration(seconds: 1));
      siradakiKelimeyiParcala();
    } else {
      renk = Colors.red;
      sifirla();
    }

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

  singleKelimeGetir() async {
    state = ViewState.geliyor;
    kelimeler = await _repository.singleKelimeGetir();
    siradakiKelimeyiParcala();
  }

  siradakiKelimeyiParcala() {
    state = ViewState.geliyor;
    ipucu.clear();
    aciklar.clear();
    tahmin.clear();
    List bolum = kelimeler[sira].icerik.split("");
    for (int i = 0; i < bolum.length; i++) {
      ipucu.addAll({i: bolum[i]});
    }
    print(ipucu);
    soru = kelimeler[sira].sorusu;
    print(soru);

    for (int i = 0; i < bolum.length; i++) {
      if (bolum[i].contains(' ')) {
        aciklar.add(i);
      }
    }
    print(aciklar);
    if (sira < kelimeler.length - 1) {
      sira++;
    } else {
      print("sa");
    }

    state = ViewState.geldi;
    notifyListeners();
  }
}
