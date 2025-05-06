// lib/features/online_inquiries/domain/repositories/repository_interface.dart

import '../entities/online_inquiries_response.dart';

/// Contrato para repositorio de consultas.
abstract class IOnlineInquiriesRepository {
  Future<OnlineInquiriesResponse> fetchResponse(String query);
}
