import 'package:equatable/equatable.dart';

import '../../domain/entities/service.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServiceLoaded extends ServiceState {
  final List<Service> services;
  final List<String> selectedServiceSlugs;

  const ServiceLoaded(
      {required this.services, this.selectedServiceSlugs = const []});

  @override
  List<Object> get props => [services, selectedServiceSlugs];

  ServiceLoaded copyWith({
    List<Service>? services,
    List<String>? selectedServiceSlugs,
  }) {
    return ServiceLoaded(
      services: services ?? this.services,
      selectedServiceSlugs: selectedServiceSlugs ?? this.selectedServiceSlugs,
    );
  }
}

class ServiceError extends ServiceState {
  final String message;

  const ServiceError({required this.message});

  @override
  List<Object> get props => [message];
}
