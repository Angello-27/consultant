// lib/features/online_inquiries/presentation/widgets/molecules/input_actions.dart
import 'package:flutter/material.dart';
import '../atoms/bubble_icon_button.dart';

//  Agrupa micro y enviar, con feedback visual de escucha.
class InputActions extends StatelessWidget {
  final VoidCallback onMic;
  final VoidCallback onSend;
  //  Indica si el servicio de STT está escuchando.
  final bool isListening;

  const InputActions({
    super.key,
    required this.onMic,
    required this.onSend,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    // Color del icono de micrófono según estado de escucha
    final micColor = isListening ? Colors.blueAccent : null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Botón de micrófono con color dinámico
        BubbleIconButton(icon: Icons.mic, color: micColor, onPressed: onMic),
        const SizedBox(width: 8),
        // Botón de enviar con color primario
        BubbleIconButton(icon: Icons.send, onPressed: onSend),
      ],
    );
  }
}
