import 'package:bloc/bloc.dart';

import '../../domain/usecases/get_services.dart';
import 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  final GetServices getServices;

  ServiceCubit({required this.getServices}) : super(ServiceInitial());

  Future<void> loadServices() async {
    emit(ServiceLoading());
    final result = await getServices();
    result.fold(
      (failure) => emit(ServiceError(message: failure.toString())),
      (services) => emit(ServiceLoaded(services: services)),
    );
  }

  void toggleServiceSelection(String serviceSlug) {
    if (state is ServiceLoaded) {
      final currentState = state as ServiceLoaded;
      List<String> updatedSelection =
          List.from(currentState.selectedServiceSlugs);

      if (updatedSelection.contains(serviceSlug)) {
        updatedSelection.remove(serviceSlug);
      } else {
        updatedSelection.add(serviceSlug);
      }

      emit(currentState.copyWith(selectedServiceSlugs: updatedSelection));
    }
  }

  void unselectAllFilters() {
    if (state is ServiceLoaded) {
      final currentState = state as ServiceLoaded;
      emit(currentState.copyWith(selectedServiceSlugs: []));
    }
  }
}
