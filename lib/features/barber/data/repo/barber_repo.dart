import 'package:dartz/dartz.dart';

import '../../../../core/api/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/barber.dart';
import '../../domain/repo/barber_repo.dart';
import '../datasources/barber_local_datasource.dart';
import '../datasources/barber_remote_datasource.dart';

class BarberRepositoryImpl implements BarberRepository {
  final BarberRemoteDataSource remoteDataSource;
  final BarberLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BarberRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Exception, List<Barber>>> getBarbers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBarbers = await remoteDataSource.getBarbers();
        localDataSource.cacheBarbers(remoteBarbers);
        return Right(remoteBarbers);
      } on ServerException catch (e) {
        return Left(e);
      } catch (e) {
        return Left(Exception(e.toString()));
      }
    } else {
      try {
        final localBarbers = await localDataSource.getLastBarbers();
        return Right(localBarbers);
      } on CacheException catch (e) {
        return Left(e);
      } catch (e) {
        return Left(Exception(e.toString()));
      }
    }
  }

  @override
  Future<Either<Exception, List<Barber>>> filterBarbers({
    bool? isShop,
    List<String>? serviceNames,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final filteredBarbers = await remoteDataSource.filterBarbers(
          isShop: isShop,
          serviceNames: serviceNames,
        );
        return Right(filteredBarbers);
      } on ServerException catch (e) {
        return Left(e);
      } catch (e) {
        return Left(Exception(e.toString()));
      }
    } else {
      return Left(NetworkException(message: 'No internet connection'));
    }
  }
}
