import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  /// Inicializa los parámetros básicos de TTS.
  Future<void> initTts() async {
    // Configura el idioma (por ejemplo, español de España)
    await _flutterTts.setLanguage("es-ES");
    // Configura la velocidad de habla (valores comunes entre 0.0 y 1.0, por ejemplo 0.5)
    await _flutterTts.setSpeechRate(0.5);
    // Configura el volumen (entre 0.0 y 1.0)
    await _flutterTts.setVolume(1.0);
    // Configura el tono (pitch, 1.0 es el tono normal)
    await _flutterTts.setPitch(1.0);
  }

  /// Reproduce el texto especificado en voz.
  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  /// Detiene la reproducción.
  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
