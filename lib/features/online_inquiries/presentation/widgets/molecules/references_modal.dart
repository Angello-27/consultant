// lib/features/online_inquiries/presentation/widgets/molecules/references_modal.dart
import 'package:flutter/material.dart';

import '../../../domain/entities/document_response.dart';

/// Muestra un modal con la lista de documentos de referencia.
class ReferencesModal {
  /// Abre un bottom sheet con las referencias proporcionadas.
  static Future<void> show(
    BuildContext context,
    List<DocumentResponse> references,
  ) {
    return showModalBottomSheet(
      context: context,
      builder:
          (_) => Container(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: references.length,
              itemBuilder: (ctx, idx) {
                final doc = references[idx];
                return ListTile(
                  title: Text(doc.metadata.source),
                  subtitle: Text(
                    doc.pageContent.length > 100
                        ? '${doc.pageContent.substring(0, 100)}...'
                        : doc.pageContent,
                  ),
                );
              },
            ),
          ),
    );
  }
}
