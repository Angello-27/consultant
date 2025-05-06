// lib/features/online_inquiries/domain/entities/online_inquiries_response.dart
import 'document.dart';

/// Entidad pura de dominio.
class OnlineInquiriesResponse {
  final String answer;
  final List<Document> context;

  OnlineInquiriesResponse({required this.answer, required this.context});
}
