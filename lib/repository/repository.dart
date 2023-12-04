import 'package:kelime_oyunu/locators.dart';
import 'package:kelime_oyunu/services/db_service.dart';

class Repository {
  final DbServices _databaseService = locator<DbServices>();

  singleKelimeGetir() async {
    return await _databaseService.singleKelimeGetir();
  }

  userRegister(Map veriler) async {
   return await _databaseService.userRegister(veriler);
   
  }

  userLogin(Map veriler) async{
     return await _databaseService.userLogin(veriler);
  }

  userGuncelle(Map veriler) async{
return await _databaseService.userGuncelle(veriler);
  }
}
