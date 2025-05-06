// lib/features/online_inquiries/data/datasources/http_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import './remote_data_source.dart';
import '../models/online_inquiries_model.dart';
import '../../../../core/configs/network_config.dart';

// Implementación HTTP del data source que llama al endpoint `/ask`.
class OnlineInquiriesRemoteDataSource
    implements IOnlineInquiriesRemoteDataSource {
  final NetworkConfig _config;

  OnlineInquiriesRemoteDataSource(this._config);

  // Envía la consulta al endpoint y convierte la respuesta en QueryChatModel.
  @override
  Future<OnlineInquiriesModel> getResponse(String query) async {
    final base = _config.serverUrl; // URL dinámica
    final uri = Uri.parse('$base/ask');
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
