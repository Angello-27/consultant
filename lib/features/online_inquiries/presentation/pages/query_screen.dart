// lib/presentation/screens/query_screen.dart
import 'package:consultant/features/online_inquiries/presentation/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/organisms/conversation_view.dart';
import '../widgets/organisms/input_area.dart';
import '../../../../core/constants/app_text_constants.dart';
import '../widgets/atoms/speech_input_widget.dart';

class QueryScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  QueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final queryProvider = Provider.of<OnlineInquiriesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(AppText.queryScreenTitle)),
      body: Column(
        children: [
          Expanded(
            child: ConversationView(
              messages: [], //queryProvider.getMessages(),
              isLoading: queryProvider.isLoading,
            ),
          ),
          // Área de entrada: incluye el campo de texto y botones en una misma fila.
          InputArea(
            controller: _controller,
            onMicPressed: () {
              // Lanza un modal con SpeechInputWidget
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  String recognizedText = "";
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(16.0),
                        constraints: const BoxConstraints(minHeight: 200),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SpeechInputWidget(
                              onResult: (text) {
                                // Actualizar el estado local del modal para mostrar el texto reconocido.
                                setState(() {
                                  recognizedText = text;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              recognizedText.isEmpty
                                  ? "Escuchando..."
                                  : recognizedText,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // Actualiza el TextEditingController con el texto reconocido.
                                _controller.text = recognizedText;
                                // Extrae la consulta y valida que no esté vacía.
                                final query = recognizedText.trim();
                                if (query.isNotEmpty) {
                                  // Envía la consulta usando el QueryProvider.
                                  Provider.of<OnlineInquiriesProvider>(
                                    context,
                                    listen: false,
                                  ).send(query);
                                  // Limpia el controlador para preparar la nueva consulta.
                                  _controller.clear();
                                }
                                // Cierra el modal.
                                Navigator.of(context).pop();
                              },
                              child: const Text("Confirmar"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            onSubmit: () {
              final query = _controller.text.trim();
              if (query.isNotEmpty) {
                queryProvider.send(query);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
