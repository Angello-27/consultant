import 'package:consultant/features/online_inquiries/domain/entities/document.dart';

class Message {
  final String text;
  final bool isUser;
  final bool isError; // Nuevo campo para diferenciar error
  final List<Document>? references;

  Message({
    required this.text,
    required this.isUser,
    this.isError = false,
    this.references,
  });
}
