import 'package:compiled/domain/facade_export.dart';
import 'package:compiled/infracstructure/exports.dart';
import 'package:get_it/get_it.dart';

import 'application/exports.dart';

final getIt = GetIt.instance;

void startServiceLocator() {
  // Applications Services
  getIt.registerFactory(() => AuthCubit(authFacade: getIt()));

  // Facades
  getIt.registerLazySingleton<IAuthFacade>(
      () => AuthFacade(network: getIt(), cache: getIt()));

  // Managers
  getIt.registerLazySingleton(() => CacheManager());
  getIt.registerLazySingleton(() => NetworkManager());

  // Core
}
