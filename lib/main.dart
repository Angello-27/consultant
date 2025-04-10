import 'package:consultant/core/constants/app_text_constants.dart';
import 'package:consultant/core/utils/tts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/configs/dependency_injections.dart' as inject;
import 'presentation/screens/query_screen.dart';
import 'presentation/providers/query_provider.dart';

void main() {
  inject.setupDependencies(); // Configura la inyección de dependencias.
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Usa Provider para inyectar la instancia de QueryProvider registrada en GetIt.
        ChangeNotifierProvider<QueryProvider>(
          create: (_) => inject.instance<QueryProvider>(),
        ),
        // Asegúrate de incluir también un Provider para TtsService, si no está inyectado a través del QueryProvider.
        Provider<TtsService>(create: (_) => inject.instance<TtsService>()),
      ],
      child: _MaterialApp(),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppText.appTitle,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QueryScreen(),
    );
  }
}
