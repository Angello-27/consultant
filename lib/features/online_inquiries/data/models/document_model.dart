// lib/features/online_inquiries/data/models/document_model.dart
import './document_metadata_model.dart';
import '../../domain/entities/document_response.dart';

class DocumentModel {
  final String id;
  final DocumentMetadataModel metadata;
  final String pageContent;
  final String type;

  DocumentModel({
    required this.id,
    required this.metadata,
    required this.pageContent,
    required this.type,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
    id: json['id'] as String,
    metadata: DocumentMetadataModel.fromJson(
      json['metadata'] as Map<String, dynamic>,
    ),
    pageContent: json['page_content'] as String,
    type: json['type'] as String,
  );

  // Conviértelo a tu entidad de dominio limpia.
  DocumentResponse toEntity() {
    return DocumentResponse(
      id: id,
      metadata: metadata.toEntity(),
      pageContent: pageContent,
      type: type,
    );
  }
}
