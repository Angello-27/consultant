// lib/features/online_inquiries/presentation/widgets/molecules/input_actions.dart
import 'package:flutter/material.dart';
import '../atoms/bubble_icon_button.dart';

/// Agrupa micro y enviar, pero como iconos junto al TextField.
class InputActions extends StatelessWidget {
  final VoidCallback onMic;
  final VoidCallback onSend;

  const InputActions({super.key, required this.onMic, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BubbleIconButton(icon: Icons.mic, onPressed: onMic),
        const SizedBox(width: 8),
        BubbleIconButton(icon: Icons.send, onPressed: onSend),
      ],
    );
  }
}
