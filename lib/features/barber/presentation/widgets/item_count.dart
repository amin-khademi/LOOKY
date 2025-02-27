import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';
import 'package:new_horizen_test_app/features/barber/presentation/cubit/barber_cubits.dart';
import 'package:new_horizen_test_app/features/barber/presentation/cubit/barber_state.dart';
import 'package:new_horizen_test_app/features/services/presentation/cubit/service_cubits.dart';
import 'package:new_horizen_test_app/features/services/presentation/cubit/service_state.dart';

class ItemCount extends StatelessWidget {
  const ItemCount({
    super.key,
    required this.isShopFilterActive,
  });

  final bool isShopFilterActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildBarberCount(context),
          const Spacer(),
          _buildFilterContainer(context),
        ],
      ),
    );
  }

  Widget _buildBarberCount(BuildContext context) {
    return BlocBuilder<BarberCubit, BarberState>(
      builder: (context, state) {
        int barberCount = 0;
        int shopCount = 0;
        if (state is BarberLoaded) {
          barberCount = state.barbers.where((barber) => !barber.isShop).length;
          shopCount = state.barbers.where((barber) => barber.isShop).length;
        }
        return Text(
          'Barbers: $barberCount, Shops: $shopCount',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white, fontSize: 18),
        );
      },
    );
  }

  Widget _buildFilterContainer(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        int activeFilters = _calculateActiveFilters(state);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 4),
          decoration: _buildContainerDecoration(activeFilters),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image(AppIcons.icFilter, color: _getFilterIconColor(activeFilters)),
              const SizedBox(width: 8),
              _buildFilterText(context),
            ],
          ),
        );
      },
    );
  }

  int _calculateActiveFilters(ServiceState state) {
    int activeFilters = 0;
    if (isShopFilterActive) activeFilters++;
    if (state is ServiceLoaded) {
      activeFilters += state.selectedServiceSlugs.length;
    }
    return activeFilters;
  }

  BoxDecoration _buildContainerDecoration(int activeFilters) {
    return BoxDecoration(
      border: Border.all(
        color: activeFilters > 0 ? Colors.transparent : AppColors.color1,
        width: 1,
      ),
      color: activeFilters > 0 ? AppColors.color1 : Colors.transparent,
      borderRadius: BorderRadius.circular(33),
    );
  }

  Color _getFilterIconColor(int activeFilters) {
    return activeFilters > 0 ? AppColors.color2 : AppColors.color1;
  }

  Widget _buildFilterText(BuildContext context) {
    return BlocBuilder<ServiceCubit, ServiceState>(
      builder: (context, state) {
        int activeFilters = 0;
        if (isShopFilterActive) activeFilters++;
        if (state is ServiceLoaded) {
          activeFilters += state.selectedServiceSlugs.length;
        }
        return Text(
          activeFilters > 0 ? "Filters $activeFilters" : "Filters",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: activeFilters > 0 ? AppColors.color : AppColors.color1),
        );
      },
    );
  }
}
