import 'package:equatable/equatable.dart';

import '../../domain/entities/barber.dart';

abstract class BarberState extends Equatable {
  const BarberState();

  @override
  List<Object?> get props => [];
}

class BarberInitial extends BarberState {}

class BarberLoading extends BarberState {}

class BarberLoaded extends BarberState {
  final List<Barber> barbers;
  final bool? isShopFilter;
  final List<String>? serviceNamesFilter;

  const BarberLoaded({
    required this.barbers,
    this.isShopFilter,
    this.serviceNamesFilter,
  });

  @override
  List<Object?> get props => [
        barbers,
        isShopFilter,
        serviceNamesFilter,
      ];

  BarberLoaded copyWith({
    List<Barber>? barbers,
    bool? isShopFilter,
    List<String>? serviceNamesFilter,
  }) {
    return BarberLoaded(
      barbers: barbers ?? this.barbers,
      isShopFilter: isShopFilter ?? this.isShopFilter,
      serviceNamesFilter: serviceNamesFilter ?? this.serviceNamesFilter,
    );
  }
}

// Make sure to add this field to your existing BarberError class
class BarberError extends BarberState {
  final String message;
  final String?
      type; // Can be 'server', 'cache', 'network' or null for unknown errors

  BarberError({required this.message, this.type});
}
