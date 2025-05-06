// lib/features/online_inquiries/presentation/providers/provider.dart

import './provider_contract.dart';
import '../../domain/use_cases/use_case_contract.dart';
import '../../domain/entities/chat_interaction.dart';

// ChangeNotifier que implementa IOnlineInquiriesProviderContract.
class OnlineInquiriesProvider extends IOnlineInquiriesProviderContract {
  final IOnlineInquiriesUseCase _useCase;

  OnlineInquiriesProvider({required IOnlineInquiriesUseCase useCase})
    : _useCase = useCase,
      super(); // llama al constructor de ChangeNotifier

  bool _isLoading = false;
  @override
  bool get isLoading => _isLoading;

  final List<ChatInteraction> _history = [];
  @override
  List<ChatInteraction> get history => List.unmodifiable(_history);

  // Envía la consulta, actualiza el estado y desencadena TTS.
  @override
  Future<void> send(String query) async {
    if (query.trim().isEmpty) {
      notifyListeners();
      return;
    }

    // Añade la interacción inicial con solo la pregunta
    _history.add(ChatInteraction(question: query));
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _useCase.execute(query);
      // Completa la interacción con la respuesta
      _history[_history.length - 1] = ChatInteraction(
        question: query,
        response: response,
      );
    } catch (e) {
      // Completa la interacción con el error
      _history[_history.length - 1] = ChatInteraction(
        question: query,
        error: e.toString(),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
