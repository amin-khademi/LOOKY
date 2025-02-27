import 'dart:convert';

import 'package:new_horizen_test_app/core/api/exceptions.dart';
import 'package:new_horizen_test_app/features/barber/data/model/barber_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BarberLocalDataSource {
  Future<List<BarberModel>> getLastBarbers();
  Future<void> cacheBarbers(List<BarberModel> barbers);
}

const cachedBarbers = 'CACHED_BARBERS';

class BarberLocalDataSourceImpl implements BarberLocalDataSource {
  final SharedPreferences sharedPreferences;

  BarberLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<BarberModel>> getLastBarbers() {
    final jsonString = sharedPreferences.getString(cachedBarbers);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return Future.value(
        jsonList.map((e) => BarberModel.fromJson(e)).toList(),
      );
    } else {
      throw CacheException(message: 'No cached barbers found');
    }
  }

  @override
  Future<void> cacheBarbers(List<BarberModel> barbers) {
    final List<Map<String, dynamic>> jsonList =
        barbers.map((barber) => barber.toJson()).toList();
    return sharedPreferences.setString(
      cachedBarbers,
      json.encode(jsonList),
    );
  }
}
