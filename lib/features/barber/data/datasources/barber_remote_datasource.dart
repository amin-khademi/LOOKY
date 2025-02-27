import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoint.dart';
import '../../../../core/api/exceptions.dart';
import '../model/barber_model.dart';

abstract class BarberRemoteDataSource {
  Future<List<BarberModel>> getBarbers();
  Future<List<BarberModel>> filterBarbers(
      {bool? isShop, List<String>? serviceNames});
}

class BarberRemoteDataSourceImpl implements BarberRemoteDataSource {
  final ApiClient client;
  BarberRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BarberModel>> getBarbers() async {
    try {
      final response = await client.get(ApiEndpoint.barbers);
      if (response == null || response['results'] == null) {
        throw ServerException(message: 'Failed to fetch barbers');
      }
      return (response['results'] as List)
          .map((barber) => BarberModel.fromJson(barber))
          .toList();
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BarberModel>> filterBarbers(
      {bool? isShop, List<String>? serviceNames}) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (isShop != null) {
        queryParams['is_shop'] = isShop.toString();
      }

      final response = await client.get(
        ApiEndpoint.barbers,
        queryParameters: queryParams,
      );

      if (response == null || response['results'] == null) {
        throw ServerException(message: 'Failed to fetch filtered barbers');
      }

      List<BarberModel> barbers = (response['results'] as List)
          .map((barber) => BarberModel.fromJson(barber))
          .toList();
      if (serviceNames != null && serviceNames.isNotEmpty) {
        barbers = barbers.where((barber) {
          return barber.services
              .any((service) => serviceNames.contains(service));
        }).toList();
      }
      return barbers;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
