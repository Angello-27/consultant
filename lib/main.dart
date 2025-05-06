// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/configs/app_root.dart';
import 'core/configs/app_providers.dart';
import 'core/configs/dependency_injections.dart' as inject;

/// Punto de entrada de la aplicación.
void main() {
  inject.setupDependencies();
  runApp(const MainApp());
}

/// Widget principal que envuelve la aplicación en los Providers necesarios.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Manejador de inyecciones globales
      providers: AppProviders.providers,
      child: const AppRoot(),
    );
  }
}
