// lib/features/online_inquiries/presentation/widgets/organisms/input_area.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../atoms/expandable_text_field.dart';
import '../molecules/input_actions.dart';
import '../../../presentation/providers/provider_contract.dart';
import '../../../../../core/constants/app_text_constants.dart';

// Organism que combina el campo de texto y los botones de acción (mic + enviar).
class InputArea extends StatefulWidget {
  const InputArea({super.key});

  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {
  final _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Sincroniza el texto reconocido cuando cambia en el provider
    final provider = context.watch<IOnlineInquiriesProviderContract>();
    _updateControllerText(provider.recognizedText);
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene el provider completo, incluyendo STT, TTS y lógica de chat
    final provider = context.watch<IOnlineInquiriesProviderContract>();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // Campo de texto expandible, se actualiza con recognizedText
          Expanded(child: _buildTextField()),
          const SizedBox(width: 8),
          // Botones de acción: micrófono y enviar
          _buildActions(provider),
        ],
      ),
    );
  }

  // Construye el campo de texto y aplica límites de líneas.
  Widget _buildTextField() {
    return ExpandableTextField(
      controller: _controller,
      hint: AppText.queryFieldLabel,
      maxLines: 5,
    );
  }

  // Construye los botones de acción delegando al provider las operaciones.
  Widget _buildActions(IOnlineInquiriesProviderContract provider) {
    return InputActions(
      isListening: provider.isListening,
      onMic: () => _toggleListening(provider),
      onSend: () => _submitQuery(provider),
    );
  }

  // Alterna entre iniciar/detener el reconocimiento de voz.
  Future<void> _toggleListening(
    IOnlineInquiriesProviderContract provider,
  ) async {
    if (provider.isListening) {
      await provider.stopListening();
    } else {
      await provider.startListening();
    }
  }

  // Envía la consulta al provider y limpia el campo.
  void _submitQuery(IOnlineInquiriesProviderContract provider) {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      provider.send(text);
      _controller.clear();
    }
  }

  // Actualiza el controlador sin perder el cursor.
  void _updateControllerText(String newText) {
    _controller
      ..text = newText
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      );
  }
}
