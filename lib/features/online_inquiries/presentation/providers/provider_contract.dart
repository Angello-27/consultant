// lib/features/online_inquiries/presentation/providers/provider_contract.dart
import 'package:flutter/foundation.dart';

import '../../domain/entities/chat_interaction.dart';

// La abstracción que tu UI va a consumir extiende ChangeNotifier para poder usarla.
abstract class IOnlineInquiriesProviderContract extends ChangeNotifier {
  /// Historial completo de interacciones (pregunta + respuesta o error).
  List<ChatInteraction> get history;

  /// Indica si hay una petición en curso.
  bool get isLoading;

  /// Envía una nueva pregunta y agrega la interacción al historial.
  Future<void> send(String query);
}
