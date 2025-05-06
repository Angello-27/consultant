// lib/features/online_inquiries/data/datasources/http_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/online_inquiries_model.dart';
import 'remote_data_source.dart';

// Implementación HTTP del data source que llama al endpoint `/ask`.
class OnlineInquiriesRemoteDataSource
    implements IOnlineInquiriesRemoteDataSource {
  final String baseUrl;

  OnlineInquiriesRemoteDataSource({required this.baseUrl});

  // Envía la consulta al endpoint y convierte la respuesta en QueryChatModel.
  @override
  Future<OnlineInquiriesModel> getResponse(String query) async {
    final uri = Uri.parse('$baseUrl/ask');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'query': query}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error en servidor: ${response.statusCode}');
    }

    final jsonBody =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return OnlineInquiriesModel.fromJson(jsonBody);
  }
}
