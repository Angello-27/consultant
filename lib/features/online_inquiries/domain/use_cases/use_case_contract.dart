// lib/features/online_inquiries/domain/usecases/use_case_contract.dart

import '../entities/online_inquiries_response.dart';

/// Contrato para el caso de uso de consulta.
abstract class IOnlineInquiriesUseCase {
  Future<OnlineInquiriesResponse> execute(String query);
}
