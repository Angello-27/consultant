import 'document.dart';

class QueryResponse {
  final String answer;
  final List<Document> context;

  QueryResponse({required this.answer, required this.context});

  factory QueryResponse.fromJson(Map<String, dynamic> json) {
    var contextList = <Document>[];
    if (json['context'] != null) {
      contextList =
          (json['context'] as List)
              .map((doc) => Document.fromJson(doc))
              .toList();
    }
    return QueryResponse(
      answer: json['answer'] as String,
      context: contextList,
    );
  }
}
