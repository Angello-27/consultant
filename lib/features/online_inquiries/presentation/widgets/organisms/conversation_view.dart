// lib/features/online_inquiries/presentation/widgets/organisms/conversation_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../atoms/loading_indicator.dart';
import '../molecules/chat_bubble.dart';
import '../molecules/references_modal.dart';
import '../../../domain/entities/chat_interaction.dart';
import '../../../presentation/providers/provider_contract.dart';

class ConversationView extends StatelessWidget {
  const ConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí uso la abstracción, no la implementación concreta
    final provider = context.watch<IOnlineInquiriesProviderContract>();
    final history = provider.history; // Lista de ChatInteraction

    // Dos burbujas por interacción: pregunta + respuesta/error.
    final itemCount = history.length * 2;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      itemBuilder: (ctx, idx) {
        // Determina índice de interacción y si es la respuesta
        final index = idx ~/ 2;
        final isAnswer = idx.isOdd;
        final interaction = history[index];

        return isAnswer
            ? _buildAnswerBubble(context, interaction)
            : _buildQuestionBubble(interaction.question);
      },
    );
  }

  Widget _buildQuestionBubble(String question) {
    return ChatBubble(text: question, isUser: true);
  }

  Widget _buildAnswerBubble(BuildContext context, ChatInteraction interaction) {
    // Error
    if (interaction.error != null) {
      return ChatBubble(text: interaction.error!, isUser: false, isError: true);
    }

    // Si la respuesta aún no llegó, mostramos progressiveDots:
    if (interaction.response == null) {
      return LoadingIndicator();
    }

    // Respuesta válida
    final response = interaction.response!;

    // Burbujas de respuesta con copy y referencias dentro,
    // y un botón de audio fuera a la derecha.
    return ChatBubble(
      text: response.answer,
      isUser: false,
      // Icono de audio (aparecerá a la derecha del texto).
      onPlay: () {
        /*final tts = Provider.of<TtsService>(context, listen: false);
        tts.speak(response.answer);*/
      },
      // Icono de copiar (aparecerá en la fila de abajo).
      onCopy: () {
        Clipboard.setData(ClipboardData(text: response.answer));
      },
      // Icono de referencias (aparecerá en la fila de abajo).
      onViewReferences:
          response.context.isNotEmpty
              ? (refs) => ReferencesModal.show(context, refs)
              : null,
      // Datos para la referencia
      references: response.context,
    );
  }
}
