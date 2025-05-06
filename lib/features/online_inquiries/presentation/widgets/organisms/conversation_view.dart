// lib/features/online_inquiries/presentation/widgets/organisms/conversation_view.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../molecules/chat_bubble.dart';
import '../molecules/references_modal.dart';
import '../atoms/bubble_icon_button.dart';
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

    // Respuesta válida
    final response = interaction.response!;

    // Burbujas de respuesta con copy y referencias dentro,
    // y un botón de audio fuera a la derecha.
    final bubble = ChatBubble(
      text: response.answer,
      isUser: false,
      onCopy: () {
        Clipboard.setData(ClipboardData(text: response.answer));
      },
      onViewReferences:
          response.context.isNotEmpty
              ? (refs) => ReferencesModal.show(context, refs)
              : null,
    );

    final audioButton = BubbleIconButton(
      icon: Icons.volume_up,
      onPressed: () {
        /*final tts = Provider.of<TtsService>(context, listen: false);
        tts.speak(response.answer);*/
      },
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Expanded(child: bubble), audioButton],
    );
  }
}
