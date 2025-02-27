import 'package:new_horizen_test_app/features/services/domain/entities/service.dart';

class ServiceModel extends Service {
  const ServiceModel({
    required super.slug,
    required super.title,
    super.icon,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      slug: json['slug'],
      title: json['title'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'title': title,
      'icon': icon,
    };
  }
}
