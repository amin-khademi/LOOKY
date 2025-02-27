import 'package:dartz/dartz.dart';
import 'package:new_horizen_test_app/features/services/domain/entities/service.dart';
import 'package:new_horizen_test_app/features/services/domain/repo/service_repo.dart';

class GetServices {
  final ServiceRepository repository;

  GetServices(this.repository);

  Future<Either<Exception, List<Service>>> call() async {
    return await repository.getServices();
  }
}
