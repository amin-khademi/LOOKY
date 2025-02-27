import 'package:flutter/material.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';

class SearchBarApp extends StatelessWidget {
  const SearchBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.color1,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search in Barbers, Location and Services...',
          hintStyle: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.black45, fontSize: 14),
          suffixIcon: _buildSuffixIcon(),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return Container(
      width: 37,
      height: 37,
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.color5,
        borderRadius: BorderRadius.circular(13),
      ),
      child: image(AppIcons.icSearch),
    );
  }
}