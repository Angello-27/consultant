import 'package:flutter/material.dart';
import '../../../domain/entities/query_response.dart';
import '../../../../core/constants/app_text_constants.dart';

class QueryResultDisplay extends StatelessWidget {
  final QueryResponse? response;
  final String error;

  const QueryResultDisplay({
    super.key,
    required this.response,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (error.isNotEmpty) {
      return Text(
        '${AppText.errorPrefix}$error',
        style: const TextStyle(color: Colors.red),
      );
    }
    if (response == null) {
      return const SizedBox(); // O un widget vacío.
    }
    return Text(response!.answer);
  }
}
