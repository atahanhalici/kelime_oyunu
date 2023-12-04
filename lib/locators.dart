import 'package:get_it/get_it.dart';
import 'package:kelime_oyunu/repository/repository.dart';
import 'package:kelime_oyunu/services/db_service.dart';
import 'package:kelime_oyunu/services/local_db_service.dart';

final locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => Repository());
  locator.registerLazySingleton(() => DbServices());
  locator.registerLazySingleton(() => LocalDbService());
}
