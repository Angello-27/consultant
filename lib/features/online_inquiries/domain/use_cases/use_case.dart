// lib/features/online_inquiries/domain/usecases/use_case.dart

import 'use_case_contract.dart';
import '../entities/online_inquiries_response.dart';
import '../repositories/repository_interface.dart';

/// Implementación de IQueryUseCase que delega al repositorio.
class OnlineInquiriesUseCase implements IOnlineInquiriesUseCase {
  final IOnlineInquiriesRepository repository;

  OnlineInquiriesUseCase({required this.repository});

  /// Ejecuta la consulta usando el repositorio.
  @override
  Future<OnlineInquiriesResponse> execute(String query) {
    return repository.fetchResponse(query);
  }
}
