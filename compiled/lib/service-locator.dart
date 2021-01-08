import 'package:compiled/domain/facade_export.dart';
import 'package:compiled/infrastructure/exports.dart';
import 'package:get_it/get_it.dart';

import 'application/exports.dart';

final getIt = GetIt.instance;

void startServiceLocator() {
  // Applications Services
  getIt.registerFactory(() => AuthCubit(authFacade: getIt()));
  getIt.registerFactory(() => PatientsCubit(patientFacade: getIt()));
  getIt.registerFactory(() => LocationCubit(locationFacade: getIt()));
  getIt.registerFactory(() => GPSCubit(locationFacade: getIt()));

  // Facades
  getIt.registerLazySingleton<IAuthFacade>(
      () => AuthFacade(network: getIt(), cache: getIt()));

  getIt.registerLazySingleton<IPatientFacade>(
      () => PatientFacade(fileManager: getIt()));
  getIt.registerLazySingleton<ILocationFacade>(
      () => LocationFacade(fileManager: getIt()));

  // Managers
  getIt.registerLazySingleton(() => CacheManager());
  getIt.registerLazySingleton(() => NetworkManager());
  getIt.registerLazySingleton(() => FileManager());

  // Core
}
