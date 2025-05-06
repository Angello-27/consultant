// lib/features/online_inquiries/presentation/widgets/atoms/loading_indicator.dart

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// Indicador de carga basado en progressiveDots de loading_animation_widget.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: LoadingAnimationWidget.progressiveDots(
        color: Theme.of(context).primaryColor,
        size: 48,
      ),
    );
  }
}
