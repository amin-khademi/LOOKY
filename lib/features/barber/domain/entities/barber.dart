import 'package:equatable/equatable.dart';

class Barber extends Equatable {
  final String slug;
  final String fullname;
  final bool isShop;
  final String? avatar;
  final String? address;
  final double? lat;
  final double? lon;
  final double rate;
  final double distance;
  final bool isBookmarked;
  final String? phoneNumber;
  final int reviewsCount;
  final List<String> services;

  const Barber({
    required this.slug,
    required this.fullname,
    required this.isShop,
    this.avatar,
    this.address,
    this.lat,
    this.lon,
    required this.rate,
    required this.distance,
    required this.isBookmarked,
    this.phoneNumber,
    required this.reviewsCount,
    required this.services,
  });

  @override
  List<Object?> get props => [
        slug,
        fullname,
        isShop,
        avatar,
        address,
        lat,
        lon,
        rate,
        distance,
        isBookmarked,
        phoneNumber,
        reviewsCount,
        services,
      ];
}
