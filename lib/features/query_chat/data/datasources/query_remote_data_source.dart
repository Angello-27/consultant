// lib/features/query_chat/data/datasources/query_remote_data_source.dart
import '../models/query_model.dart';

/// Contrato para la fuente remota de datos.
abstract class IQueryRemoteDataSource {
  Future<QueryModel> getQueryResponse(String query);
}
