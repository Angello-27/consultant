// lib/features/online_inquiries/data/repositories/repository.dart
import 'repository_interface.dart';
import '../entities/online_inquiries_response.dart';
import '../../data/datasources/remote_data_source.dart';

/// Implementación de IQueryRepository.
class OnlineInquiriesRepository implements IOnlineInquiriesRepository {
  final IOnlineInquiriesRemoteDataSource remote;

  OnlineInquiriesRepository({required this.remote});

  @override
  Future<OnlineInquiriesResponse> fetchResponse(String query) async {
    final model = await remote.getResponse(query);
    return model.toEntity();
  }
}
