// lib/features/online_inquiries/data/models/document_metadata_model.dart
import '../../domain/entities/document_metadata_response.dart';

class DocumentMetadataModel {
  final String source;
  final List<String> tags;

  DocumentMetadataModel({required this.source, required this.tags});

  factory DocumentMetadataModel.fromJson(Map<String, dynamic> json) =>
      DocumentMetadataModel(
        source: json['source'] as String,
        tags: List<String>.from(json['tags'] as List<dynamic>),
      );

  // Conviértelo a tu entidad de dominio limpia.
  DocumentMetadataResponse toEntity() {
    return DocumentMetadataResponse(source: source, tags: tags);
  }
}
