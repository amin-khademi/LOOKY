import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';
import 'package:new_horizen_test_app/features/services/presentation/cubit/service_cubits.dart';

import '../cubit/barber_cubits.dart';
import '../cubit/barber_state.dart';
import 'barber_list_item.dart';

class BarberListSection extends StatelessWidget {
  const BarberListSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarberCubit, BarberState>(
      builder: (context, barberState) {
        if (barberState is BarberLoading) {
          return _buildBarbersLoadingShimmer();
        } else if (barberState is BarberError) {
          return _buildErrorWidget(barberState.message, context);
        } else if (barberState is BarberLoaded) {
          return _buildBarbersList(barberState.barbers);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBarbersList(List<dynamic> barbers) {
    return barbers.isEmpty
        ? _emptySate()
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: barbers.length,
            itemBuilder: (context, index) {
              return BarberListItem(barber: barbers[index]);
            },
          );
  }

  Widget _emptySate() {
    return Center(
      child: Column(
        children: [
          Lottie.asset(AppAnimations.empty, repeat: false),
          const Text(
            "Nothing to see here!",
            style: TextStyle(
                color: AppColors.color1,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }

  Widget _buildBarbersLoadingShimmer() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => const BarberItemShimmer(),
    );
  }

  Widget _buildErrorWidget(String message, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: AppColors.color5,
              child: const Text("Retry"),
              onPressed: () {
                context.read<ServiceCubit>().unselectAllFilters();
                context.read<BarberCubit>().loadBarbers();
              },
            ),
            const SizedBox(height: 32)
          ],
        ),
      ),
    );
  }
}
