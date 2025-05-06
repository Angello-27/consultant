import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/query_response.dart';

class QueryApiClient {
  // La URL del servidor se define en core/config.dart
  final String baseUrl;

  QueryApiClient({required this.baseUrl});

  Future<QueryResponse> postQuery(String query) async {
    final url = Uri.parse('$baseUrl/ask');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'query': query}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      if (data['answer'] is Map<String, dynamic>) {
        return QueryResponse.fromJson(data['answer']);
      } else if (data['answer'] is String) {
        // Si la API retorna un string plano, se construye la entidad con contexto vacío.
        return QueryResponse(answer: data['answer'], context: []);
      } else {
        throw Exception('Formato de respuesta desconocido');
      }
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
