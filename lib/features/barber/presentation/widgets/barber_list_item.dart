import 'package:flutter/material.dart';
import 'package:new_horizen_test_app/core/theme/theme.dart';
import 'package:new_horizen_test_app/core/widgets/widgets.dart';

import '../../domain/entities/barber.dart';

class BarberListItem extends StatelessWidget {
  final Barber barber;

  const BarberListItem({Key? key, required this.barber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
      side:  BorderSide(color: AppColors.color4.withOpacity(0.8), width: 3),
      ),
      child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        _BarberImage(avatar: barber.avatar),
        const SizedBox(width: 16),
        Expanded(child: _BarberDetails(barber: barber)),
        ],
      ),
      ),
    );
  }
}

class _BarberImage extends StatelessWidget {
  final String? avatar;

  const _BarberImage({Key? key, this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: avatar != null && avatar!.isNotEmpty
          ? image(
              avatar!,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            )
          : _defaultAvatar(),
    );
  }

  Widget _defaultAvatar() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.grey.shade300,
      child: const Icon(Icons.person, size: 40),
    );
  }
}

class _BarberDetails extends StatelessWidget {
  final Barber barber;

  const _BarberDetails({Key? key, required this.barber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BarberNameAndRating(barber: barber),
        const SizedBox(height: 16),
        if (barber.services.isNotEmpty) _BarberServices(services: barber.services),
        const SizedBox(height: 16),
        if (barber.address != null && barber.address!.isNotEmpty)
          _BarberAddress(address: barber.address!),
      ],
    );
  }
}

class _BarberNameAndRating extends StatelessWidget {
  final Barber barber;

  const _BarberNameAndRating({Key? key, required this.barber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              _buildName(context),
              const SizedBox(width: 6),
              if (!barber.isShop) image(AppIcons.icBlueTick),
            ],
          ),
        ),
        if (barber.rate > 0) _buildRating(context),
      ],
    );
  }

  Widget _buildName(BuildContext context) {
    return Text(
      barber.fullname.length > 20
          ? '${barber.fullname.substring(0, 20)}...'
          : barber.fullname,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.color2, fontSize: 18),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRating(BuildContext context) {
    return Row(
      children: [
        image(AppIcons.icStar),
        const SizedBox(width: 4),
        Text(
          barber.rate.toString(),
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: AppColors.color6, fontSize: 14),
        ),
      ],
    );
  }
}

class _BarberServices extends StatelessWidget {
  final List<String> services;

  const _BarberServices({Key? key, required this.services}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      services.join(', '),
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.color4, fontSize: 14),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _BarberAddress extends StatelessWidget {
  final String address;

  const _BarberAddress({Key? key, required this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text: TextSpan(
        style: const TextStyle(fontSize: 13, color: Colors.black),
        children: [
          _buildDistance(context),
          _buildAddress(context)
        ],
      ),
    );
  }

  TextSpan _buildDistance(BuildContext context) {
    return TextSpan(
      text: "${address.split(' ')[0]} Kms | ",
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: AppColors.color5, fontSize: 14),
    );
  }

  TextSpan _buildAddress(BuildContext context) {
    return TextSpan(
      text: address.substring(address.indexOf(' ') + 1),
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: AppColors.color4, fontSize: 14),
    );
  }
}
