import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';

import '../../domain/entities/service.dart';
import '../cubit/service_cubits.dart';
import '../cubit/service_state.dart';

class ServiceItem extends StatelessWidget {
  final Service service;

  const ServiceItem({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        bool isSelected = _isSelected(state);

        return GestureDetector(
          onTap: () => _toggleServiceSelection(context),
          child: _buildServiceContainer(context, isSelected),
        );
      },
    );
  }

  bool _isSelected(ServiceState state) {
    if (state is ServiceLoaded) {
      return state.selectedServiceSlugs.contains(service.slug);
    }
    return false;
  }

  void _toggleServiceSelection(BuildContext context) =>
      context.read<ServiceCubit>().toggleServiceSelection(service.slug);

  Widget _buildServiceContainer(BuildContext context, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildServiceBox(context, isSelected),
      ],
    );
  }

  Widget _buildServiceBox(BuildContext context, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      margin: const EdgeInsets.only(right: 10),
      decoration: _buildBoxDecoration(isSelected),
      child: _buildServiceText(context),
    );
  }

  BoxDecoration _buildBoxDecoration(bool isSelected) {
    return BoxDecoration(
      border: Border.all(color: AppColors.color7, width: 1),
      color: isSelected ? AppColors.color6 : Colors.transparent,
      borderRadius: BorderRadius.circular(33),
    );
  }

  Text _buildServiceText(BuildContext context) {
    return Text(
      service.title,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
