// lib/features/query_chat/data/repositories/query_repository_impl.dart
import '../../domain/entities/query_response.dart';
import '../../domain/repositories/query_repository.dart';
import '../../data/datasources/query_remote_data_source.dart';

/// Implementación de IQueryRepository.
class QueryRepositoryImpl implements IQueryRepository {
  final IQueryRemoteDataSource remote;

  QueryRepositoryImpl({required this.remote});

  @override
  Future<QueryResponse> fetchResponse(String query) =>
      remote.getQueryResponse(query).then((model) => model.toEntity());
}
