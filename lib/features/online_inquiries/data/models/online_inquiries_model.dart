// lib/features/online_inquiries/data/models/online_inquiries_model.dart
import '../../domain/entities/online_inquiries_response.dart';

import './document_model.dart';

// Modelo que representa exactamente el JSON del endpoint
class OnlineInquiriesModel {
  final String answer;
  final List<DocumentModel> context;

  OnlineInquiriesModel({required this.answer, required this.context});

  factory OnlineInquiriesModel.fromJson(Map<String, dynamic> json) {
    // La respuesta 'answer' a veces es Map, a veces String
    final rawAnswer = json['answer'];
    final parsedAnswer =
        rawAnswer is String
            ? rawAnswer
            : (rawAnswer['text'] as String? ?? rawAnswer.toString());

    // Parseo de contexto a lista de Document
    final ctx =
        (json['context'] as List<dynamic>?)
            ?.cast<Map<String, dynamic>>()
            .map((doc) => DocumentModel.fromJson(doc))
            .toList() ??
        [];

    return OnlineInquiriesModel(answer: parsedAnswer, context: ctx);
  }

  // Conviértelo a tu entidad de dominio limpia.
  OnlineInquiriesResponse toEntity() {
    return OnlineInquiriesResponse(
      answer: answer,
      context: context.map((m) => m.toEntity()).toList(),
    );
  }
}
