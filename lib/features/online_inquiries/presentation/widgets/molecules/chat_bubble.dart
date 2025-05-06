// lib/features/online_inquiries/presentation/widgets/molecules/chat_bubble.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../atoms/bubble_icon_button.dart';
import '../../../domain/entities/document_response.dart';
import '../../../../../core/configs/settings_service.dart';

typedef VoidDocumentList = void Function(List<DocumentResponse> refs);

// Burbujas de chat con texto y acciones.
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

  Alignment _alignment() =>
      isUser ? Alignment.centerRight : Alignment.centerLeft;

  EdgeInsets _margin() => EdgeInsets.only(
    left: isUser ? 50 : 8,
    right: isUser ? 8 : 50,
    top: 4,
    bottom: 4,
  );

  BorderRadius _borderRadius() => BorderRadius.only(
    topLeft: const Radius.circular(12),
    topRight: const Radius.circular(12),
    bottomLeft: isUser ? const Radius.circular(12) : Radius.zero,
    bottomRight: isUser ? Radius.zero : const Radius.circular(12),
  );

  Color _bubbleColor(BuildContext context) {
    if (isError) return Colors.red[100]!;
    return isUser ? Colors.blue[100]! : Colors.grey[200]!;
  }

  bool _hasBottomActions() =>
      !isUser && (onCopy != null || onViewReferences != null);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: _alignment(),
      child: Container(
        margin: _margin(),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _bubbleColor(context),
          borderRadius: _borderRadius(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContentRow(context),
            if (_hasBottomActions()) const SizedBox(height: 8),
            if (_hasBottomActions()) _buildActionRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildContentRow(BuildContext context) {
    final settings = context.watch<SettingsService>();
    final icon = settings.audioEnabled ? Icons.volume_up : Icons.volume_off;
    final color = settings.audioEnabled ? Colors.blueAccent : Colors.blueGrey;
    // El propio contenedor de texto
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            text,
            style: TextStyle(color: isError ? Colors.red : Colors.black),
          ),
        ),
        // Icono de audio a la derecha (solo para respuestas)
        if (!isUser && onPlay != null) ...[
          const SizedBox(width: 8),
          BubbleIconButton(icon: icon, onPressed: onPlay!, color: color),
        ],
      ],
    );
  }

  Widget _buildActionRow() {
    final buttons = <Widget>[];
    if (onCopy != null) {
      buttons
        ..add(BubbleIconButton(icon: Icons.copy, onPressed: onCopy!))
        ..add(const SizedBox(width: 8));
    }
    if (onViewReferences != null) {
      buttons.add(
        BubbleIconButton(
          icon: Icons.link,
          onPressed: () => onViewReferences!(references!),
        ),
      );
    }
    return Row(mainAxisSize: MainAxisSize.min, children: buttons);
  }
}
