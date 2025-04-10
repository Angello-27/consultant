// lib/presentation/widgets/organisms/input_area.dart
import 'package:flutter/material.dart';
import '../../widgets/atoms/custom_text_field.dart';
import '../../../core/constants/app_text_constants.dart';

class InputArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final VoidCallback onMicPressed;

  const InputArea({
    super.key,
    required this.controller,
    required this.onSubmit,
    required this.onMicPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: controller,
              label: AppText.queryFieldLabel,
            ),
          ),
          const SizedBox(width: 8),
          // Botón para activar el reconocimiento de voz.
          IconButton(
            icon: const Icon(Icons.mic, size: 32),
            onPressed: onMicPressed,
          ),
          const SizedBox(width: 8),
          // Botón para enviar la consulta.
          IconButton(
            icon: const Icon(Icons.send, size: 32),
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}
