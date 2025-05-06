import '../datasources/query_api_client.dart';
import '../../domain/entities/query_response.dart';

class QueryRepository {
  final QueryApiClient apiClient;

  QueryRepository({required this.apiClient});

  Future<QueryResponse> fetchAnswer(String query) async {
    return await apiClient.postQuery(query);
  }
}
