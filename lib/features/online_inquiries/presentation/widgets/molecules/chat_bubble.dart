// lib/features/online_inquiries/presentation/widgets/molecules/chat_bubble.dart
import 'package:flutter/material.dart';
import '../atoms/bubble_icon_button.dart';

import '../../../domain/entities/document_response.dart';

typedef VoidDocumentList = void Function(List<DocumentResponse> refs);

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isError;
  final List<DocumentResponse>? references;
  final VoidDocumentList? onViewReferences;
  final VoidCallback? onPlay;
  final VoidCallback? onCopy;

  const ChatBubble({
    super.key,
    required this.text,
    this.isUser = false,
    this.isError = false,
    this.references,
    this.onViewReferences,
    this.onPlay,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final color =
        isError
            ? Colors.red[100]
            : (isUser ? Colors.blue[100] : Colors.grey[200]);
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(12),
      topRight: const Radius.circular(12),
      bottomLeft: radiusForBottomLeft(),
      bottomRight: radiusForBottomRight(),
    );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color, borderRadius: radius),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Texto expandible
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(color: isError ? Colors.red : null),
                ),
              ),
              const SizedBox(width: 8),
              // Íconos de acción dentro de la burbuja
              if (onPlay != null)
                BubbleIconButton(icon: Icons.volume_up, onPressed: onPlay!),
              if (onCopy != null)
                BubbleIconButton(icon: Icons.copy, onPressed: onCopy!),
              if (!isUser && onViewReferences != null && references != null)
                BubbleIconButton(
                  icon: Icons.link,
                  onPressed: () => onViewReferences!(references!),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Radius radiusForBottomLeft() =>
      isUser ? const Radius.circular(12) : const Radius.circular(0);
  Radius radiusForBottomRight() =>
      isUser ? const Radius.circular(0) : const Radius.circular(12);
}
