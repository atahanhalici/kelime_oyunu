import 'package:kelime_oyunu/locators.dart';
import 'package:kelime_oyunu/services/db_service.dart';
import 'package:kelime_oyunu/services/local_db_service.dart';

class Repository {
  final DbServices _databaseService = locator<DbServices>();
  final LocalDbService _localdatabaseService = locator<LocalDbService>();

  singleKelimeGetir() async {
    return await _databaseService.singleKelimeGetir();
  }

  userRegister(Map veriler) async {
    return await _databaseService.userRegister(veriler);
  }

  userLogin(Map veriler) async {
    return await _databaseService.userLogin(veriler);
  }

  userGuncelle(Map veriler) async {
    return await _databaseService.userGuncelle(veriler);
  }

  misafirGiris() async {
    return await _localdatabaseService.misafirGiris();
  }

  Future<String> beniHatirlaKontrol() async {
    return await _localdatabaseService.beniHatirlaKontrol();
  }

  userGetir(String id) async {
    return await _databaseService.userGetir(id);
  }

  cikisYap() async {
    await _localdatabaseService.cikisYap();
  }

  sifreYenile(String eski, String yeni, String id) async {
    return await _databaseService.sifreYenile(eski, yeni, id);
  }

  puanEkle(String id, int puan) async{
    return await _databaseService.puanEkle(id, puan);
  }

  misafirPuanEkle(int puan) async{
   return await _localdatabaseService.misafirPuanEkle(puan);
  }

  sifremiUnuttum(String email) async{
return await _databaseService.sifremiUnuttum(email);
  }
}
