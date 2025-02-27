import 'package:dartz/dartz.dart';
import 'package:new_horizen_test_app/core/api/exceptions.dart';
import 'package:new_horizen_test_app/core/network/network_info.dart';
import 'package:new_horizen_test_app/features/services/data/datasources/service_local_datasource.dart';
import 'package:new_horizen_test_app/features/services/data/datasources/service_remote_datasource.dart';
import 'package:new_horizen_test_app/features/services/domain/entities/service.dart';
import 'package:new_horizen_test_app/features/services/domain/repo/service_repo.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;
  final ServiceLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ServiceRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Exception, List<Service>>> getServices() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteServices = await remoteDataSource.getServices();
        localDataSource.cacheServices(remoteServices);
        return Right(remoteServices);
      } on ServerException catch (e) {
        return Left(e);
      } catch (e) {
        return Left(Exception(e.toString()));
      }
    } else {
      try {
        final localServices = await localDataSource.getLastServices();
        return Right(localServices);
      } on CacheException catch (e) {
        return Left(e);
      } catch (e) {
        return Left(Exception(e.toString()));
      }
    }
  }
}
