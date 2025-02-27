import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';
import 'package:new_horizen_test_app/features/services/domain/entities/service.dart';
import 'package:new_horizen_test_app/features/services/presentation/cubit/service_cubits.dart';
import 'package:new_horizen_test_app/features/services/presentation/cubit/service_state.dart';
import 'package:new_horizen_test_app/features/services/presentation/widgets/service_item.dart';

typedef ApplyFiltersCallback = void Function();

class ServicesListWidget extends StatelessWidget {
  final ApplyFiltersCallback onSelectionChanged;

  const ServicesListWidget({Key? key, required this.onSelectionChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, serviceState) {
        if (serviceState is ServiceLoading) {
          return _buildServicesLoadingShimmer();
        } else if (serviceState is ServiceError) {
          return _buildErrorWidget(serviceState.message, context);
        } else if (serviceState is ServiceLoaded) {
          return _buildServicesList(serviceState.services, context);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildServicesList(List<Service> services, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      height: 31,
      child: BlocConsumer<ServiceCubit, ServiceState>(
        listenWhen: (previous, current) {
          if (previous is ServiceLoaded && current is ServiceLoaded) {
            return previous.selectedServiceSlugs !=
                current.selectedServiceSlugs;
          }
          return false;
        },
        listener: (context, state) {
          if (state is ServiceLoaded) {
            onSelectionChanged();
          }
        },
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            itemBuilder: (context, index) {
              return ServiceItem(service: services[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildServicesLoadingShimmer() {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: 5,
        itemBuilder: (context, index) => const ServiceItemShimmer(),
      ),
    );
  }

  Widget _buildErrorWidget(String message, BuildContext context) {
    // Your error widget implementation here
    return Center(child: Text(message));
  }
}
