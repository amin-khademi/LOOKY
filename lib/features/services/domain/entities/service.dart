import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final String slug;
  final String title;
  final String? icon;

  const Service({
    required this.slug,
    required this.title,
    this.icon,
  });

  @override
  List<Object?> get props => [slug, title, icon];
}
