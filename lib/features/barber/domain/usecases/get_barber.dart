import 'package:dartz/dartz.dart';

import '../entities/barber.dart';
import '../repo/barber_repo.dart';

class GetBarbers {
  final BarberRepository repository;
  GetBarbers(this.repository);

  Future<Either<Exception, List<Barber>>> call() async {
    return await repository.getBarbers();
  }
}
