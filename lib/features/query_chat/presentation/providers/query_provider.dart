// lib/features/query_chat/presentation/providers/query_provider.dart

import 'package:consultant/features/query_chat/domain/use_cases/query_use_case.dart';
import 'package:consultant/shared/utils/tts_service.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/query_response.dart';

/// Contrato para el proveedor de estado de la consulta.
abstract class IQueryProvider {
  QueryResponse? get response;
  bool get isLoading;
  String? get error;
  Future<void> sendQuery(String query);
}

/// ChangeNotifier que implementa IQueryProvider.
class QueryProvider extends ChangeNotifier implements IQueryProvider {
  final IQueryUseCase _useCase;
  final TtsService _ttsService;

  QueryProvider({
    required IQueryUseCase queryUseCase,
    required TtsService ttsService,
  }) : _useCase = queryUseCase,
       _ttsService = ttsService;

  QueryResponse? _response;
  bool _isLoading = false;
  String? _error;

  @override
  QueryResponse? get response => _response;

  @override
  bool get isLoading => _isLoading;

  @override
  String? get error => _error;

  /// Envía la consulta, actualiza el estado y desencadena TTS.
  @override
  Future<void> sendQuery(String query) async {
    if (query.trim().isEmpty) {
      _error = 'Consulta vacía';
      notifyListeners();
      return;
    }
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _useCase.execute(query);
      _response = result;
      _ttsService.speak(result.answer);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
