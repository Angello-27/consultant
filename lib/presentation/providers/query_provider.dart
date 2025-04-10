import 'package:consultant/core/utils/tts_service.dart';
import 'package:flutter/material.dart';
import '../../domain/use_cases/query_use_case.dart';
import '../../domain/entities/query_response.dart';
import '../../domain/entities/message.dart';

class QueryProvider extends ChangeNotifier {
  final QueryUseCase queryUseCase;
  final TtsService ttsService;

  bool isLoading = false;
  final List<Message> _messages = [];
  String errorMessage = '';

  List<Message> getMessages() => _messages;

  QueryProvider({required this.queryUseCase, required this.ttsService});

  Future<void> sendQuery(String query) async {
    isLoading = true;
    errorMessage = '';
    _messages.add(Message(text: query, isUser: true));
    notifyListeners();

    try {
      QueryResponse response = await queryUseCase.execute(query);
      _messages.add(
        Message(
          text: response.answer,
          isUser: false,
          references: response.context,
        ),
      );
    } catch (e) {
      errorMessage = e.toString();
      _messages.add(
        Message(text: 'Error: $errorMessage', isUser: false, isError: true),
      );
    }

    isLoading = false;
    notifyListeners();
  }
}
