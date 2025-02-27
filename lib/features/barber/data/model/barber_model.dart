import '../../domain/entities/barber.dart';

class BarberModel extends Barber {
  const BarberModel({
    required super.slug,
    required super.fullname,
    required super.isShop,
    super.avatar,
    super.address,
    super.lat,
    super.lon,
    required super.rate,
    required super.distance,
    required super.isBookmarked,
    super.phoneNumber,
    required super.reviewsCount,
    required super.services,
  });

  factory BarberModel.fromJson(Map<String, dynamic> json) {
    return BarberModel(
      slug: json['slug'],
      fullname: json['fullname'],
      isShop: json['is_shop'] ?? false,
      avatar: json['avatar'],
      address: json['address'],
      lat: json['lat']?.toDouble(),
      lon: json['lon']?.toDouble(),
      rate: json['rate']?.toDouble() ?? 0.0,
      distance: json['distance']?.toDouble() ?? 0.0,
      isBookmarked: json['is_bookmarked'] ?? false,
      phoneNumber: json['phone_number'],
      reviewsCount: json['reviews_count'] ?? 0,
      services:
          json['services'] != null ? List<String>.from(json['services']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'fullname': fullname,
      'is_shop': isShop,
      'avatar': avatar,
      'address': address,
      'lat': lat,
      'lon': lon,
      'rate': rate,
      'distance': distance,
      'is_bookmarked': isBookmarked,
      'phone_number': phoneNumber,
      'reviews_count': reviewsCount,
      'services': services,
    };
  }
}
