// lib/features/online_inquiries/domain/entities/document_response.dart
import 'document_metadata_response.dart';

class DocumentResponse {
  final String id;
  final DocumentMetadataResponse metadata;
  final String pageContent;
  final String type;

  DocumentResponse({
    required this.id,
    required this.metadata,
    required this.pageContent,
    required this.type,
  });
}
