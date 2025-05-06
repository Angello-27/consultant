import 'package:consultant/features/online_inquiries/domain/entities/document_response.dart';

class Message {
  final String text;
  final bool isUser;
  final bool isError; // Nuevo campo para diferenciar error
  final List<DocumentResponse>? references;

  Message({
    required this.text,
    required this.isUser,
    this.isError = false,
    this.references,
  });
}
