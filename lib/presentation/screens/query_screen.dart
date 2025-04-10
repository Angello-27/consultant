// lib/presentation/screens/query_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/query_provider.dart';
import '../widgets/organisms/conversation_view.dart';
import '../widgets/organisms/input_area.dart';
import '../../core/constants/app_text_constants.dart';

class QueryScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  QueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final queryProvider = Provider.of<QueryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppText.queryScreenTitle)),
      body: Column(
        children: [
          Expanded(
            child: ConversationView(
              messages: queryProvider.getMessages(),
              isLoading: queryProvider.isLoading,
            ),
          ),
          // Aquí se utiliza el InputArea actualizado con ambos botones al mismo nivel.
          InputArea(
            controller: _controller,
            onMicPressed: () {
              // Aquí invocas la función para activar el speech-to-text.
              // Por ejemplo, podrías mostrar un diálogo o llamar a un método en un Provider dedicado.
              // Ejemplo:
              // Provider.of<SpeechProvider>(context, listen: false).startListening();
              // O bien, mostrar un widget modal para la captura de voz.
            },
            onSubmit: () {
              final query = _controller.text.trim();
              if (query.isNotEmpty) {
                queryProvider.sendQuery(query);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
