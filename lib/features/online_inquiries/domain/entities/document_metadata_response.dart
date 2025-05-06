// lib/features/online_inquiries/domain/entities/document_metadata_response.dart

// Información adicional de un documento consultado:
class DocumentMetadataResponse {
  final String source;
  final List<String> tags;

  DocumentMetadataResponse({required this.source, required this.tags});
}
