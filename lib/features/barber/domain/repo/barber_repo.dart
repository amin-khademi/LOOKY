import 'package:dartz/dartz.dart';

import '../entities/barber.dart';

abstract class BarberRepository {
  Future<Either<Exception, List<Barber>>> getBarbers();
  Future<Either<Exception, List<Barber>>> filterBarbers({
    bool? isShop,
    List<String>? serviceNames,
  });
}
