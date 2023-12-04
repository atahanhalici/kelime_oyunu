import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kelime_oyunu/locators.dart';
import 'package:kelime_oyunu/models/user.dart';
import 'package:kelime_oyunu/repository/repository.dart';

enum ViewStates { geliyor, geldi, hata }

class UserViewModel with ChangeNotifier {
  final Repository _repository = locator<Repository>();
  ViewStates _state = ViewStates.geliyor;
  ViewStates get state => _state;
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
  int sayac = 0;
  String beniHatirla = "a";
  set state(ViewStates value) {
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

  misafirGiris() async {
    var sonuc = await _repository.misafirGiris();
    user.puan = sonuc["puan"];
    user.sonsoru = sonuc["sonsoru"];
    user.id = "0";
  }

  Future<String> beniHatirlaKontrol() async {
    if (sayac == 0) {
      await Future.delayed(const Duration(seconds: 3));

      beniHatirla = await _repository.beniHatirlaKontrol();

      if (beniHatirla != "0") {
        var sonuc = await userGetir(beniHatirla);
        user = sonuc["user"];
      }
      sayac++;
      state = ViewStates.geldi;
      notifyListeners();
    }

    return beniHatirla;
  }

  userGetir(String id) async {
    var sonuc = await _repository.userGetir(id);
    return sonuc;
  }

  void beniHatirlaDegis(id) {
    beniHatirla = id;
    notifyListeners();
  }

  cikisYap() async {
    user = User(
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
    await _repository.cikisYap();
  }
}
