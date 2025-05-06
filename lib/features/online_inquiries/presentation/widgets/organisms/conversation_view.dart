// lib/features/online_inquiries/presentation/widgets/organisms/conversation_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../molecules/chat_bubble.dart';
import '../atoms/loading_indicator.dart';
import '../../../presentation/providers/provider_contract.dart';

class ConversationView extends StatelessWidget {
  const ConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    // Aquí uso la abstracción, no la implementación concreta
    final prov = context.watch<IOnlineInquiriesProviderContract>();
    final messages =
        prov.response?.context
            .map((doc) => doc.pageContent) // o convierte cada doc a Message
            .toList() ??
        [];
    final isLoading = prov.isLoading;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length + (isLoading ? 1 : 0),
      itemBuilder: (ctx, i) {
        if (i < messages.length) {
          final text = messages[i];
          return ChatBubble(
            text: text,
            isUser: i.isEven, // alterna o usa tu lista de Message con flag
            onPlay: () => {} /* llama TtsService */,
            onCopy: () => {} /* copia al portapapeles */,
            onViewReferences: (refs) => prov.send(text), // reemplazar con modal
            references: prov.response?.context,
          );
        }
        return const Center(child: LoadingIndicator());
      },
    );
  }
}
