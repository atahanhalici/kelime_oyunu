import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kelime_oyunu/locators.dart';
import 'package:kelime_oyunu/models/user.dart';
import 'package:kelime_oyunu/models/word.dart';
import 'package:kelime_oyunu/repository/repository.dart';

enum ViewState { geliyor, geldi, hata }

class UserViewModel with ChangeNotifier {
  final Repository _repository = locator<Repository>();
  ViewState _state = ViewState.geliyor;
  ViewState get state => _state;
  User user = User(
      sonsoru: 0,
      onlinepuan: 0,
      puan: 0,
      avatar: "",
      emailAktif: false,
      id: "",
      email: "",
      kullaniciadi: "",
      sifre: "",
      v: 0);

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  userRegister(Map veriler) async {
    return await _repository.userRegister(veriler);
  }

  Future<Map> userLogin(Map veriler) async {
    var sonuc = await _repository.userLogin(veriler);
    user = sonuc["user"];
    return sonuc;
  }

  guncelle(Map veriler) async {
    var sonuc = await _repository.userGuncelle(veriler);
    user = sonuc["user"];
    print(user);
    return sonuc;
  }
}
