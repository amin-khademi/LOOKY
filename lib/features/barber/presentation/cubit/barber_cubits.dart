import 'package:bloc/bloc.dart';

import '../../domain/usecases/filter_barbers.dart';
import '../../domain/usecases/get_barber.dart';
import 'barber_state.dart';

class BarberCubit extends Cubit<BarberState> {
  final GetBarbers getBarbers;
  final FilterBarbers filterBarbers;

  BarberCubit({
    required this.getBarbers,
    required this.filterBarbers,
  }) : super(BarberInitial());

  Future<void> loadBarbers() async {
    emit(BarberLoading());
    final result = await getBarbers();
    result.fold(
      (failure) => emit(BarberError(message: failure.toString())),
      (barbers) => emit(BarberLoaded(barbers: barbers)),
    );
  }

  Future<void> applyFilters({bool? isShop, List<String>? serviceNames}) async {
    emit(BarberLoading());
    final result =
        await filterBarbers(isShop: isShop, serviceNames: serviceNames);
    result.fold(
      (failure) => emit(BarberError(message: failure.toString())),
      (barbers) => emit(
        BarberLoaded(barbers: barbers, isShopFilter: isShop),
      ),
    );
  }
}
