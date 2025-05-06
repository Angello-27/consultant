// lib/core/utils/stt_service.dart
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

// Servicio para reconocimiento de voz (STT), maneja permisos y escucha.
class SttService {
  final SpeechToText _speech = SpeechToText();

  // Inicializa permisos y motor de STT.
  Future<bool> init({required void Function(String) onStatus}) async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) return false;
    return await _speech.initialize(onError: (_) {}, onStatus: onStatus);
  }

  // Los resultados parciales llegan vía onResult cada vez que se reconoce algo.
  Future<void> listen({required void Function(String) onResult}) async {
    await _speech.listen(
      onResult: (SpeechRecognitionResult result) {
        // result.recognizedWords: texto hasta ahora
        // result.finalResult: indica si este fragmento es definitivo
        onResult(result.recognizedWords);
      },
      listenOptions: SpeechListenOptions(
        partialResults: true, // activa los resultados intermedios
        // autoPunctuation: true, // opcional: añade puntuación automática
        // listenMode: ListenMode.dictation, // u otro modo según caso
      ),
    );
  }

  // Detiene la escucha.
  Future<void> stop() async => await _speech.stop();
}
