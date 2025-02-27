import 'package:flutter/material.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        width: 120,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.color1.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image(AppIcons.icLocation, color: AppColors.color1.withOpacity(0.8)),
            const SizedBox(width: 8),
            Text(
              "Ranchview",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.color1.withOpacity(0.5),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
