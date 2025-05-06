// lib/core/utils/stt_service.dart
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

/// Servicio para reconocimiento de voz (STT), maneja permisos y escucha.
class SttService {
  final SpeechToText _speech = SpeechToText();

  /// Inicializa permisos y motor de STT.
  Future<bool> init() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) return false;
    return await _speech.initialize(onError: (_) {}, onStatus: (_) {});
  }

  /// Empieza a escuchar; cada resultado se notifica en [onResult].
  Future<void> listen({required void Function(String) onResult}) async {
    await _speech.listen(
      onResult: (result) => onResult(result.recognizedWords),
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 3),
    );
  }

  /// Detiene la escucha.
  Future<void> stop() async => await _speech.stop();
}
