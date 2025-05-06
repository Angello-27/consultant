// lib/features/online_inquiries/presentation/widgets/atoms/expandable_text_field.dart
import 'package:flutter/material.dart';

/// TextField que crece hasta [maxLines] conforme el usuario escribe.
class ExpandableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const ExpandableTextField({
    super.key,
    required this.controller,
    this.hint = '',
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 1,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
