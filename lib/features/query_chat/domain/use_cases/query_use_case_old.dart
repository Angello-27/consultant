import '../../data/repositories/query_repository.dart';
import '../entities/query_response.dart';

class QueryUseCase {
  final QueryRepository repository;

  QueryUseCase({required this.repository});

  Future<QueryResponse> execute(String query) async {
    return await repository.fetchAnswer(query);
  }
}
