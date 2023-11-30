import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kelime_oyunu/locators.dart';
import 'package:kelime_oyunu/repository/repository.dart';

enum ViewStatees { geliyor, geldi, hata }

class SingleViewModel with ChangeNotifier {
  final Repository _repository = locator<Repository>();
  ViewStatees _state = ViewStatees.geliyor;
  ViewStatees get state => _state;
  List aciklar = [4];
  Map<int, String> tahmin = {};
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
    9: "s",
  };
  
  Color renk = Colors.black;
  set state(ViewStatees value) {
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

  void kontrol() {
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
    } else {
      renk = Colors.red;
    }
    notifyListeners();
  }

  void renkSifirla() {
    renk = Colors.black;
    notifyListeners();
  }
}
