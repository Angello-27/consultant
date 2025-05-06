// lib/core/configs/dependency_injections.dart
import 'package:get_it/get_it.dart';

import './app_network.dart';
import './settings_service.dart';
import '../../shared/utils/tts_service.dart';
import '../../shared/utils/stt_service.dart';
import '../../features/online_inquiries/config/injection.dart'
    as online_inquiries_inject;

final instance = GetIt.instance;

/// Registra todas las dependencias de la aplicación divididas por feature.
void setupDependencies() {
  // Url del Servidor
  String baseUrl = AppNetwork.serverUrl;

  // Config y servicios globales
  instance.registerLazySingleton<SettingsService>(() => SettingsService());
  instance.registerLazySingleton<SttService>(() => SttService());
  instance.registerLazySingleton<TtsService>(() => TtsService()..initTts());

  // Feature: registro de dependecias para las consultas en linea
  online_inquiries_inject.registerOnlineInquiriesDependencies(
    instance,
    baseUrl,
  );
}
