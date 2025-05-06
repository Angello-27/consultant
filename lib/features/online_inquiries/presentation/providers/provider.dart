// lib/features/online_inquiries/presentation/providers/provider.dart
import './provider_contract.dart';
import '../../domain/use_cases/use_case_contract.dart';
import '../../domain/entities/online_inquiries_response.dart';
import '../../../../core/constants/app_text_constants.dart';

// ChangeNotifier que implementa IOnlineInquiriesProviderContract.
class OnlineInquiriesProvider extends IOnlineInquiriesProviderContract {
  final IOnlineInquiriesUseCase _useCase;

  OnlineInquiriesProvider({required IOnlineInquiriesUseCase useCase})
    : _useCase = useCase,
      super(); // llama al constructor de ChangeNotifier

  bool _isLoading = false;
  @override
  bool get isLoading => _isLoading;

  String? _error;
  @override
  String? get error => _error;

  OnlineInquiriesResponse? _response;
  @override
  OnlineInquiriesResponse? get response => _response;

  // Envía la consulta, actualiza el estado y desencadena TTS.
  @override
  Future<void> send(String query) async {
    if (query.trim().isEmpty) {
      _error = AppText.emptyQueryError;
      notifyListeners();
      return;
    }

    _error = null;
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _useCase.execute(query);
      _response = result;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
