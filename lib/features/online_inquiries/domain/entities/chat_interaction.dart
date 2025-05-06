// lib/features/online_inquiries/domain/entities/chat_interaction.dart
import 'online_inquiries_response.dart';

// Representa una interacción completa:
// la pregunta del usuario y la respuesta del asistente.
class ChatInteraction {
  final String question; // Texto que puso el usuario
  // Respuesta del asistente (puede ser null si hay error)
  final OnlineInquiriesResponse? response;
  final String? error; // Texto de error, en caso de fallo

  ChatInteraction({required this.question, this.response, this.error});
}
