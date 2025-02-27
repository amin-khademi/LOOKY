import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/features/barber/presentation/widgets/barber_list.dart';
import 'package:new_horizen_test_app/features/barber/presentation/widgets/header.dart';
import 'package:new_horizen_test_app/features/barber/presentation/widgets/item_count.dart';
import 'package:new_horizen_test_app/features/barber/presentation/widgets/location.dart';
import 'package:new_horizen_test_app/features/barber/presentation/widgets/near_by.dart';
import 'package:new_horizen_test_app/features/barber/presentation/widgets/search_bar.dart';
import 'package:new_horizen_test_app/features/barber/presentation/widgets/services.dart';
import 'package:new_horizen_test_app/features/barber/presentation/widgets/services_list.dart';

import '../../../services/presentation/cubit/service_cubits.dart';
import '../../../services/presentation/cubit/service_state.dart';
import '../cubit/barber_cubits.dart';

class BarbersPage extends StatefulWidget {
  const BarbersPage({Key? key}) : super(key: key);

  @override
  State<BarbersPage> createState() => _BarbersPageState();
}

class _BarbersPageState extends State<BarbersPage> {
  bool _isShopFilterActive = false;

  @override
  void initState() {
    super.initState();
    context.read<ServiceCubit>().loadServices();
    context.read<BarberCubit>().loadBarbers();
  }

  @override
  Widget build(BuildContext context) => Scaffold(body: _body());

  Widget _body() {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ServiceCubit>().loadServices();
        context.read<BarberCubit>().loadBarbers();
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 32),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const LocationWidget(),
            const Header(),
            const SearchBarApp(),
            ServiceFilterBar(),
            const SizedBox(height: 27),
            NearBy(context: context),
            const SizedBox(height: 26),
            ItemCount(isShopFilterActive: _isShopFilterActive),
            const SizedBox(height: 16),
            // services chip
            ServicesListWidget(onSelectionChanged: _applyFilters),
            const SizedBox(height: 8),
            const Divider(
              height: 0.2,
            ),
            // Shop filter toggle
            _shopSwitch(),
            // Barbers list
            const BarberListSection(),
          ],
        ),
      ),
    );
  }

  Widget _shopSwitch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text('Show Shops Only',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white, fontSize: 16)),
          const Spacer(),
          Switch(
            thumbColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.color5;
                }
                return AppColors.color4;
              },
            ),
            trackColor: WidgetStateProperty.all(AppColors.color1),
            value: _isShopFilterActive,
            onChanged: (value) {
              setState(() => _isShopFilterActive = value);
              _applyFilters();
            },
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    final serviceState = context.read<ServiceCubit>().state;
    List<String>? selectedServiceNames;

    if (serviceState is ServiceLoaded &&
        serviceState.selectedServiceSlugs.isNotEmpty) {
      selectedServiceNames = serviceState.selectedServiceSlugs;
    }

    context.read<BarberCubit>().applyFilters(
          isShop: _isShopFilterActive ? true : null,
          serviceNames: selectedServiceNames,
        );
  }
}
