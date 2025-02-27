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
        bool isSelected = false;
        if (state is ServiceLoaded) {
          isSelected = state.selectedServiceSlugs.contains(service.slug);
        }

        return GestureDetector(
          onTap: () {
            context.read<ServiceCubit>().toggleServiceSelection(service.slug);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color:AppColors.color7, width: 1),
                  color: isSelected ? AppColors.color6 : Colors.transparent,
                  borderRadius: BorderRadius.circular(33),
                ),
                child: Text(
                  service.title,
                 style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
