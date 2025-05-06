// lib/features/query_chat/data/datasources/query_remote_data_source_impl.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/query_model.dart';
import 'query_remote_data_source.dart';

/// Implementación de IQueryRemoteDataSource que hace llamadas HTTP.
class QueryRemoteDataSourceImpl implements IQueryRemoteDataSource {
  final String baseUrl;

  QueryRemoteDataSourceImpl({required this.baseUrl});

  /// Envía la consulta al endpoint y convierte la respuesta en QueryModel.
  @override
  Future<QueryModel> getQueryResponse(String query) async {
    final uri = Uri.parse(
      '$baseUrl/query',
    ).replace(queryParameters: {'q': query});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body) as Map<String, dynamic>;
      //return QueryModel.fromJson(jsonBody);
      return QueryModel();
    } else {
      throw Exception('Error en servidor: ${response.statusCode}');
    }
  }
}
