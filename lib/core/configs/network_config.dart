// lib/core/configs/network_config.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gestiona la URL base del servidor, guardada en SharedPreferences.
class NetworkConfig extends ChangeNotifier {
  static const _prefsKey = 'server_url';

  /// Valor por defecto (el que usabas antes).
  static const _defaultUrl = 'http://192.168.0.11:8000';

  String _serverUrl = _defaultUrl;
  String get serverUrl => _serverUrl;

  /// Carga la URL de SharedPreferences (o usa la _defaultUrl).
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _serverUrl = prefs.getString(_prefsKey) ?? _defaultUrl;
    notifyListeners();
  }

  /// Actualiza la URL en memoria y en SharedPreferences.
  Future<void> updateServerUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, url);
    _serverUrl = url;
    notifyListeners();
  }
}
