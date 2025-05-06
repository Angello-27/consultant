// lib/features/online_inquiries/presentation/providers/provider.dart
import './provider_contract.dart';
import '../../domain/use_cases/use_case_contract.dart';
import '../../domain/entities/chat_interaction.dart';
import '../../../../shared/utils/tts_service.dart';
import '../../../../core/configs/settings_service.dart';

// ChangeNotifier que implementa IOnlineInquiriesProviderContract.
class OnlineInquiriesProvider extends IOnlineInquiriesProviderContract {
  final TtsService _ttsService;
  final SettingsService _settings;
  final IOnlineInquiriesUseCase _useCase;

  OnlineInquiriesProvider({
    required IOnlineInquiriesUseCase useCase,
    required TtsService ttsService,
    required SettingsService settingsService,
  }) : _useCase = useCase,
       _ttsService = ttsService,
       _settings = settingsService,
       super(); // llama al constructor de ChangeNotifier

  bool _isLoading = false;
  @override
  bool get isLoading => _isLoading;

  @override
  bool get audioEnabled => _settings.audioEnabled;

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
      // Reproducción automática según preferencia
      playAudio(response.answer);
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

  // Reproduce el texto si la preferencia está habilitada.
  void playAudio(String text) {
    if (_settings.audioEnabled) {
      _ttsService.speak(text);
    }
  }

  @override
  void toggleAudio(String text) {
    if (_settings.audioEnabled) {
      // Si estaba activo, detenemos la reproducción
      _ttsService.stop();
    } else {
      // Si estaba desactivado, hablamos el texto
      _ttsService.speak(text);
    }
    // Cambiamos la preferencia y notificamos
    _settings.toggleAudioEnabled();
    notifyListeners();
  }
}
