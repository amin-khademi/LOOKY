import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/api/exceptions.dart';
import '../model/service_model.dart';

abstract class ServiceLocalDataSource {
  Future<List<ServiceModel>> getLastServices();
  Future<void> cacheServices(List<ServiceModel> services);
}

const cachedServices = 'CACHED_SERVICES';

class ServiceLocalDataSourceImpl implements ServiceLocalDataSource {
  final SharedPreferences sharedPreferences;

  ServiceLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ServiceModel>> getLastServices() {
    final jsonString = sharedPreferences.getString(cachedServices);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return Future.value(
        jsonList.map((e) => ServiceModel.fromJson(e)).toList(),
      );
    } else {
      throw CacheException(message: 'No cached services found');
    }
  }

  @override
  Future<void> cacheServices(List<ServiceModel> services) {
    final List<Map<String, dynamic>> jsonList =
        services.map((service) => service.toJson()).toList();
    return sharedPreferences.setString(
      cachedServices,
      json.encode(jsonList),
    );
  }
}
