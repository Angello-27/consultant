// lib/features/query_chat/domain/usecases/query_use_case.dart

import '../entities/query_response.dart';

/// Contrato para el caso de uso de consulta.
abstract class IQueryUseCase {
  Future<QueryResponse> execute(String query);
}
