import 'package:bloc/bloc.dart';
import 'package:new_horizen_test_app/core/api/exceptions.dart';

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
      (failure) => emit(_handleError(failure)),
      (barbers) => emit(BarberLoaded(barbers: barbers)),
    );
  }

  Future<void> applyFilters({bool? isShop, List<String>? serviceNames}) async {
    emit(BarberLoading());
    final result =
        await filterBarbers(isShop: isShop, serviceNames: serviceNames);
    result.fold(
      (failure) => emit(_handleError(failure)),
      (barbers) => emit(
        BarberLoaded(barbers: barbers, isShopFilter: isShop),
      ),
    );
  }

  BarberState _handleError(dynamic failure) {
    if (failure is ServerException) {
      return BarberError(
          message: 'Unable to connect to server. Please try again later.',
          type: 'server');
    } else if (failure is CacheException) {
      return BarberError(
          message: 'Could not load saved data. Please restart the app.',
          type: 'cache');
    } else if (failure is NetworkException) {
      return BarberError(
          message:
              'No internet connection. Please check your network settings.',
          type: 'network');
    } else {
      return BarberError(
          message: 'An unexpected error occurred. Please try again.',
          type: 'unknown');
    }
  }
}
