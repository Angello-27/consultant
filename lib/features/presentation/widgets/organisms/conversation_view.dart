// lib/presentation/widgets/organisms/conversation_view.dart
import 'package:flutter/material.dart';
import 'package:consultant/features/domain/entities/message.dart';
import 'package:consultant/features/domain/entities/document.dart';
import '../atoms/chat_bubble.dart';
import '../atoms/loading_indicator.dart';

class ConversationView extends StatelessWidget {
  final List<Message> messages;
  final bool isLoading;

  const ConversationView({
    super.key,
    required this.messages,
    required this.isLoading,
  });

  void _showReferences(BuildContext context, List<Document> references) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: references.length,
            itemBuilder: (context, index) {
              final document = references[index];
              return ListTile(
                title: Text(
                  document.metadata["source"] ?? "Referencia ${index + 1}",
                ),
                subtitle: Text(
                  document.pageContent.length > 100
                      ? "${document.pageContent.substring(0, 100)}..."
                      : document.pageContent,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Se suma 1 al itemCount si isLoading es verdadero para mostrar el indicador al final.
    final itemCount = messages.length + (isLoading ? 1 : 0);
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index < messages.length) {
          final message = messages[index];
          return ChatBubble(
            message: message.text,
            isUser: message.isUser,
            references: message.references,
            autoPlay:
                !message
                    .isUser, // Esto hará que se auto-reproduzca para mensajes del asistente.
            onViewReferences:
                message.references != null && message.references!.isNotEmpty
                    ? () => _showReferences(context, message.references!)
                    : null,
          );
        } else {
          // Muestra el LoadingIndicator al final.
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: LoadingIndicator(),
            ),
          );
        }
      },
    );
  }
}
