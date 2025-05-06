// lib/core/configs/app_routes.dart
import 'package:flutter/widgets.dart';

import '../constants/app_route_constants.dart';
import '../../features/query_chat/presentation/pages/query_screen.dart';

// Provee configuración de rutas: mapa de rutas e inicial.
class AppRoutes {
  // Ruta inicial de la aplicación.
  static String get initialRoute => RoutesNames.query;

  // Mapa de rutas de la aplicación.
  static Map<String, WidgetBuilder> get routes => {
    RoutesNames.query: (_) => QueryScreen(),
  };
}
