// lib/core/configs/app_providers.dart
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'dependency_injections.dart' as inject;
import '../../features/query_chat/presentation/providers/query_provider.dart';

/// Lista de providers globales para MultiProvider.
class AppProviders {
  static List<SingleChildWidget> get providers => [
    ChangeNotifierProvider<QueryProvider>(
      create: (_) => inject.instance<QueryProvider>(),
    ),
  ];
}
