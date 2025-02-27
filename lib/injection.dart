import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/api_client.dart';
import 'core/network/network_info.dart';
import 'features/barber/data/datasources/barber_local_datasource.dart';
import 'features/barber/data/datasources/barber_remote_datasource.dart';
import 'features/barber/data/repo/barber_repo.dart';
import 'features/barber/domain/repo/barber_repo.dart';
import 'features/barber/domain/usecases/filter_barbers.dart';
import 'features/barber/domain/usecases/get_barber.dart';
import 'features/barber/presentation/cubit/barber_cubits.dart';
import 'features/services/data/datasources/service_local_datasource.dart';
import 'features/services/data/datasources/service_remote_datasource.dart';
import 'features/services/data/repo/service_repo.dart';
import 'features/services/domain/repo/service_repo.dart';
import 'features/services/domain/usecases/get_services.dart';
import 'features/services/presentation/cubit/service_cubits.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Barber
  // Cubits
  sl.registerFactory(() => BarberCubit(
        getBarbers: sl(),
        filterBarbers: sl(),
      ));

  // Use Cases
  sl.registerLazySingleton(() => GetBarbers(sl()));
  sl.registerLazySingleton(() => FilterBarbers(sl()));

  // Repositories
  sl.registerLazySingleton<BarberRepository>(() => BarberRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<BarberRemoteDataSource>(
      () => BarberRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<BarberLocalDataSource>(
      () => BarberLocalDataSourceImpl(sharedPreferences: sl()));

  //! Features - Service
  // Cubits
  sl.registerFactory(() => ServiceCubit(getServices: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetServices(sl()));

  // Repositories
  sl.registerLazySingleton<ServiceRepository>(() => ServiceRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<ServiceRemoteDataSource>(
      () => ServiceRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ServiceLocalDataSource>(
      () => ServiceLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => ApiClient());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
