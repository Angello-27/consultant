// lib/features/query_chat/data/repositories/query_repository_impl.dart
import '../../domain/entities/query_response.dart';
import '../../domain/repositories/query_repository.dart';
import '../datasources/query_remote_data_source.dart';

/// Implementación de IQueryRepository usando la fuente remota.
class QueryRepositoryImpl implements IQueryRepository {
  final IQueryRemoteDataSource remote;

  QueryRepositoryImpl({required this.remote});

  /// Obtiene el modelo remoto y lo convierte en entidad de dominio.
  @override
  Future<QueryResponse> fetchResponse(String query) async {
    final model = await remote.getQueryResponse(query);
    //return model.toEntity();
    return QueryResponse(answer: "", context: []);
  }
}
