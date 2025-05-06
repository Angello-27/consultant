class Document {
  final String id;
  final Map<String, dynamic> metadata;
  final String pageContent;
  final String type;

  Document({
    required this.id,
    required this.metadata,
    required this.pageContent,
    required this.type,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] as String,
      metadata: json['metadata'] as Map<String, dynamic>,
      pageContent: json['page_content'] as String,
      type: json['type'] as String,
    );
  }
}
