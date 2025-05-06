// lib/features/query_chat/domain/repositories/query_repository.dart

import '../entities/query_response.dart';

/// Contrato para repositorio de consultas.
abstract class IQueryRepository {
  Future<QueryResponse> fetchResponse(String query);
}
