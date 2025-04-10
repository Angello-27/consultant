// lib/presentation/screens/query_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/query_provider.dart';
import '../widgets/organisms/conversation_view.dart';
import '../widgets/organisms/input_area.dart';
import '../../core/constants/app_text_constants.dart';
import '../widgets/atoms/speech_input_widget.dart';

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
          InputArea(
            controller: _controller,
            onMicPressed: () {
              // Lanza el modal bottom sheet que contiene el SpeechInputWidget.
              showModalBottomSheet(
                context: context,
                isScrollControlled:
                    true, // Permite ajustar la altura según el contenido.
                builder: (context) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    // Ocupa el ancho completo y una altura mínima.
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: 200, // Ajusta según necesidad.
                    ),
                    child: SpeechInputWidget(
                      onResult: (recognizedText) {
                        // Actualiza el campo de texto con la transcripción.
                        _controller.text = recognizedText;
                        // Cierra el modal luego de capturar la voz.
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              );
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
