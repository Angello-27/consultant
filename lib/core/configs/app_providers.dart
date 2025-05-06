// lib/core/configs/app_providers.dart
import 'package:provider/provider.dart';
import 'dependency_injections.dart' as inject;
import 'package:provider/single_child_widget.dart';

import '../../features/online_inquiries/presentation/providers/provider_contract.dart';

/// Lista de providers globales para MultiProvider.
class AppProviders {
  static List<SingleChildWidget> get providers => [
    ChangeNotifierProvider<IOnlineInquiriesProviderContract>(
      create: (_) => inject.instance<IOnlineInquiriesProviderContract>(),
    ),
  ];
}
