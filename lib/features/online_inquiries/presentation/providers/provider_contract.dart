// lib/features/online_inquiries/presentation/providers/provider_contract.dart
import 'package:flutter/foundation.dart';

import '../../domain/entities/chat_interaction.dart';

// Contrato (abstracción) que expone la lógica de chat, audio y STT.
// Extiende ChangeNotifier para integrarse con Provider.
abstract class IOnlineInquiriesProviderContract extends ChangeNotifier {
  // Historial completo de interacciones (pregunta + respuesta o error).
  List<ChatInteraction> get history;

  // Indica si hay una petición en curso.
  bool get isLoading;

  // Estado actual de la preferencia de reproducción de audio.
  bool get audioEnabled;

  // Alterna la reproducción de audio (play/stop) y actualiza la preferencia.
  void toggleAudio(String text);

  // Indica si el servicio de reconocimiento de voz está escuchando.
  bool get isListening;

  // Último texto reconocido por el servicio de voz.
  String get recognizedText;

  // Inicializa el reconocimiento de voz y solicita permisos de micrófono.
  Future<bool> initSpeech();

  // Inicia la escucha de audio y actualiza `recognizedText` a medida que reconoce.
  Future<void> startListening();

  // Detiene la escucha de audio.
  Future<void> stopListening();

  // Envía una nueva pregunta al chatbot y agrega la interacción al historial.
  Future<void> send(String query);
}
