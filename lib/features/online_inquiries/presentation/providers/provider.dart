// lib/features/online_inquiries/presentation/providers/provider.dart
import './provider_contract.dart';
import '../../domain/use_cases/use_case_contract.dart';
import '../../domain/entities/chat_interaction.dart';
import '../../../../shared/utils/tts_service.dart';
import '../../../../shared/utils/stt_service.dart';
import '../../../../core/configs/settings_service.dart';

// Implementación de IOnlineInquiriesProviderContract,
// maneja chat, reproducción de texto a voz y reconocimiento de voz.
class OnlineInquiriesProvider extends IOnlineInquiriesProviderContract {
  final TtsService _ttsService;
  final SttService _sttService;
  final SettingsService _settings;
  final IOnlineInquiriesUseCase _useCase;

  OnlineInquiriesProvider({
    required IOnlineInquiriesUseCase useCase,
    required TtsService ttsService,
    required SttService sttService,
    required SettingsService settingsService,
  }) : _useCase = useCase,
       _ttsService = ttsService,
       _settings = settingsService,
       _sttService = sttService,
       super(); // llama al constructor de ChangeNotifier

  bool _isLoading = false;
  @override
  bool get isLoading => _isLoading;

  bool _isListening = false;
  @override
  bool get isListening => _isListening;

  String _recognizedText = '';
  @override
  String get recognizedText => _recognizedText;

  @override
  bool get audioEnabled => _settings.audioEnabled;

  final List<ChatInteraction> _history = [];
  @override
  List<ChatInteraction> get history => List.unmodifiable(_history);

  // Solicita permisos de micrófono e inicializa STT.
  @override
  Future<bool> initSpeech() async {
    // Pasa tu handler al inicializar STT
    return await _sttService.init(onStatus: _handleSttStatus);
  }

  // Manejador interno de estado STT
  void _handleSttStatus(String status) {
    final wasListening = _isListening;
    _isListening = (status == 'listening');
    // Solo notifica si realmente cambió
    if (_isListening != wasListening) notifyListeners();
  }

  // Envía la consulta, actualiza el estado
  // y reproduce audio automáticamente si está habilitado.
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
      _isListening = false;
      _recognizedText = ''; // limpia el texto interno
      notifyListeners();
    }
  }

  // Reproduce el texto si la preferencia está habilitada.
  void playAudio(String text) {
    if (_settings.audioEnabled) {
      _ttsService.speak(text);
    }
  }

  // Alterna reproducción de audio y actualiza preferencia.
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

  // Inicia la escucha y actualiza recognizedText en cada resultado.
  @override
  Future<void> startListening() async {
    final ready = await initSpeech();
    if (!ready) return;
    _recognizedText = '';
    // Avisamos ya que el callback podría no dispararse de inmediato
    _isListening = true;
    notifyListeners();

    await _sttService.listen(
      onResult: (text) {
        _recognizedText = text;
        notifyListeners();
      },
    );
  }

  // Detiene la escucha.
  @override
  Future<void> stopListening() async {
    await _sttService.stop();
    // El callback `_handleSttStatus` también recibirá el status='notListening'
    // pero forzamos aquí el cambio inmediato
    _isListening = false;
    notifyListeners();
  }
}
