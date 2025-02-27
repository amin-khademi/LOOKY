import 'package:flutter/material.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      children: [
        image(AppImages.cut),
        _buildTitle(theme),
        _buildSubtitle(theme),
      ],
    );
  }

  Widget _buildTitle(TextTheme theme) {
    return Text(
      "LOOKY",
      style: theme.displayLarge!.copyWith(color: AppColors.color1),
    );
  }

  Widget _buildSubtitle(TextTheme theme) {
    return Text(
      "Fastest Way to Find Barbers",
      style: theme.headlineSmall!.copyWith(color: AppColors.color3),
    );
  }
}
