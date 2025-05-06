// lib/core/configs/app_root.dart
import 'package:flutter/material.dart';
import '../constants/app_text_constants.dart';
import '../constants/app_color_constants.dart';

// Configuración principal de MaterialApp:
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppText.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: AppColor.primaryColor),
      home: Container(), // Pantalla de consulta
    );
  }
}
