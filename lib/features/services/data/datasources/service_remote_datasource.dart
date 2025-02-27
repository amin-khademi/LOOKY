import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoint.dart';
import '../../../../core/api/exceptions.dart';
import '../model/service_model.dart';

abstract class ServiceRemoteDataSource {
  Future<List<ServiceModel>> getServices();
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final ApiClient client;

  ServiceRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final response = await client.get(ApiEndpoint.services);

      if (response == null || response['results'] == null) {
        throw ServerException(message: 'Failed to fetch services');
      }

      return (response['results'] as List)
          .map((service) => ServiceModel.fromJson(service))
          .toList();
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(message: e.toString());
    }
  }
}
