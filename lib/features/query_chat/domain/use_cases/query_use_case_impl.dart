// lib/features/query_chat/domain/usecases/query_use_case_impl.dart

import '../entities/query_response.dart';
import '../repositories/query_repository.dart';
import 'query_use_case.dart';

/// Implementación de IQueryUseCase que delega al repositorio.
class QueryUseCaseImpl implements IQueryUseCase {
  final IQueryRepository repository;

  QueryUseCaseImpl({required this.repository});

  /// Ejecuta la consulta usando el repositorio.
  @override
  Future<QueryResponse> execute(String query) {
    return repository.fetchResponse(query);
  }
}
