// ignore_for_file: library_private_types_in_public_api

import 'package:consultant/features/query_chat/domain/entities/document.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../shared/utils/tts_service.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isUser;
  final bool isError;
  final List<Document>? references;
  final VoidCallback? onViewReferences;
  final bool autoPlay;

  const ChatBubble({
    super.key,
    required this.message,
    this.isUser = false,
    this.isError = false,
    this.references,
    this.onViewReferences,
    this.autoPlay = false,
  });

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool _hasPlayed = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isUser && widget.autoPlay && !_hasPlayed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ttsService = Provider.of<TtsService>(context, listen: false);
        ttsService.speak(widget.message);
        setState(() {
          _hasPlayed = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bubbleColor =
        widget.isError
            ? Colors.red[100]
            : (widget.isUser ? Colors.blue[100] : Colors.grey[300]);
    final align =
        widget.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final textAlign = widget.isUser ? TextAlign.right : TextAlign.left;

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.message,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: 16,
              color: widget.isError ? Colors.red : Colors.black,
            ),
          ),
        ),
        if (!widget.isUser &&
            widget.references != null &&
            widget.references!.isNotEmpty &&
            widget.onViewReferences != null)
          TextButton(
            onPressed: widget.onViewReferences,
            child: const Text("Ver Referencias"),
          ),
      ],
    );
  }
}
