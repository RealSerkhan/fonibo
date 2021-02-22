import 'package:fonibo/back/fonibo_api.dart';
import 'package:fonibo/back/fonibo_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => FoniboApi());
  locator.registerLazySingleton(() => FoniboRepository());
}
