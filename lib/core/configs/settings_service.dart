// lib/core/configs/settings_service.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Servicio para gestionar preferencias globales
class SettingsService extends ChangeNotifier {
  static const _audioKey = 'audio_enabled';
  bool _audioEnabled = true;

  // Valor actual de la preferencia de audio.
  bool get audioEnabled => _audioEnabled;

  // Inicializa el servicio cargando SharedPreferences.
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _audioEnabled = prefs.getBool(_audioKey) ?? true;
    notifyListeners();
  }

  // Alterna el estado de la preferencia de audio y la persiste.
  Future<void> toggleAudioEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    _audioEnabled = !_audioEnabled;
    await prefs.setBool(_audioKey, _audioEnabled);
    notifyListeners();
  }

  // Establece el estado de la preferencia de audio y la persiste.
  Future<void> setAudioEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    _audioEnabled = enabled;
    await prefs.setBool(_audioKey, enabled);
    notifyListeners();
  }
}
