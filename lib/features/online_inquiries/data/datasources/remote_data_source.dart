// lib/features/online_inquiries/data/datasources/remote_data_source.dart
import '../models/online_inquiries_model.dart';

/// Contrato para la fuente remota de datos.
abstract class IOnlineInquiriesRemoteDataSource {
  Future<OnlineInquiriesModel> getResponse(String query);
}
