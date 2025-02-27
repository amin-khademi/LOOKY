import 'package:dartz/dartz.dart';
import 'package:new_horizen_test_app/features/services/domain/entities/service.dart';

abstract class ServiceRepository {
  Future<Either<Exception, List<Service>>> getServices();
}
