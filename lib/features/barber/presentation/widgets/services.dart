import 'package:flutter/material.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';

class ServiceFilterBar extends StatelessWidget {
  ServiceFilterBar({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> services = [
    {
      'icon': AppIcons.icCut2,
      'label': 'Haircut',
    },
    {
      'icon': AppIcons.icShave,
      'label': 'Face Shave',
    },
    {
      'icon': AppIcons.icGroup136,
      'label': 'Skin Fades',
    },
    {
      'icon': AppIcons.icGroup133,
      'label': 'Coloring',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: services.map((service) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              image(service['icon'] as String),
              const SizedBox(height: 4),
              Padding(
                padding: service['label'] == 'Skin Fades'
                    ? const EdgeInsets.only(bottom: 11.0)
                    : EdgeInsets.zero,
                child: Text(
                  service['label'] as String,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: AppColors.color4, fontSize: 14),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
