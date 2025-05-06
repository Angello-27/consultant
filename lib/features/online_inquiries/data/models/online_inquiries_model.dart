// lib/features/online_inquiries/data/models/online_inquiries_model
import '../../domain/entities/document.dart';
import '../../domain/entities/online_inquiries_response.dart';

// Modelo que representa exactamente el JSON del endpoint
class OnlineInquiriesModel {
  final String answer;
  final List<Document> context;

  OnlineInquiriesModel({required this.answer, required this.context});

  factory OnlineInquiriesModel.fromJson(Map<String, dynamic> json) {
    // Manejo del campo 'answer' que puede ser String o Map
    final rawAnswer = json['answer'];
    String parsedAnswer;
    if (rawAnswer is String) {
      parsedAnswer = rawAnswer;
    } else if (rawAnswer is Map<String, dynamic> &&
        rawAnswer['text'] is String) {
      parsedAnswer = rawAnswer['text'] as String;
    } else {
      throw Exception('Formato inesperado en "answer"');
    }

    // Contexto: lista de documentos JSON o vacía
    final ctx =
        (json['context'] as List<dynamic>?)
            ?.cast<Map<String, dynamic>>()
            .map((docJson) => Document.fromJson(docJson))
            .toList() ??
        <Document>[];

    return OnlineInquiriesModel(answer: parsedAnswer, context: ctx);
  }

  // Conviértelo a tu entidad de dominio limpia.
  OnlineInquiriesResponse toEntity() {
    return OnlineInquiriesResponse(answer: answer, context: context);
  }
}
