import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';

class NearBy extends StatelessWidget {
  const NearBy({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: const DecorationImage(
          image: AssetImage(AppImages.slider),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          _buildBorderOverlay(),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildBorderOverlay() {
    return Positioned.fill(
      child: Container(
        margin: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withOpacity(0.4),
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Positioned(
      left: 24,
      top: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 4),
          _buildDescription(context),
          const SizedBox(height: 32),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        image(AppIcons.icNearby),
        const SizedBox(width: 8),
        Text(
          'Nearby You',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      'Find the nearest Barber Shop to you on the map',
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: Colors.white.withOpacity(0.7), fontSize: 15),
    );
  }

  Widget _buildButton() {
    return CupertinoButton(
      borderRadius: BorderRadius.circular(12),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      color: AppColors.color5,
      child: const Text("View the map"),
      onPressed: () {},
    );
  }
}
