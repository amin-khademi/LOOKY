import 'package:dartz/dartz.dart';

import '../entities/barber.dart';
import '../repo/barber_repo.dart';

class FilterBarbers {
  final BarberRepository repository;

  FilterBarbers(this.repository);

  Future<Either<Exception, List<Barber>>> call({
    bool? isShop,
    List<String>? serviceNames,
  }) async {
    return await repository.filterBarbers(
      isShop: isShop,
      serviceNames: serviceNames,
    );
  }
}
