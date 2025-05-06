// lib/core/configs/dependency_injections.dart
import 'package:get_it/get_it.dart';

import 'app_network.dart';
import '../../features/query_chat/config/injection.dart' as query_inject;

final instance = GetIt.instance;

/// Registra todas las dependencias de la aplicación divididas por feature.
void setupDependencies() {
  // Url del Servidor
  String baseUrl = AppNetwork.serverUrl;

  // Feature: Query Chat
  query_inject.registerQueryChatDependencies(instance, baseUrl);
}
