import 'package:flutter/material.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: _buildLocationContainer(context),
    );
  }

  Widget _buildLocationContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 120,
      height: 30,
      decoration: _buildBoxDecoration(),
      child: _buildLocationRow(context),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: AppColors.color1.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _buildLocationRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image(AppIcons.icLocation, color: AppColors.color1.withOpacity(0.8)),
        const SizedBox(width: 8),
        _buildLocationText(context),
      ],
    );
  }

  Widget _buildLocationText(BuildContext context) {
    return Text(
      "Ranchview",
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.color1.withOpacity(0.5),
          ),
    );
  }
}
