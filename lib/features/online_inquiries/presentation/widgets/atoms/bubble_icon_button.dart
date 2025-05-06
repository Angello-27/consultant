// lib/features/online_inquiries/presentation/widgets/atoms/bubble_icon_button.dart
import 'package:flutter/material.dart';

/// Botón circular para iconos dentro de una burbuja.
class BubbleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const BubbleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          icon,
          size: 20,
          color: color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
