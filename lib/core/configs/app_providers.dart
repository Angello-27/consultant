// lib/core/configs/app_providers.dart
import 'package:provider/provider.dart';
import 'dependency_injections.dart' as inject;
import 'package:provider/single_child_widget.dart';

import './settings_service.dart';
import '../../shared/utils/stt_service.dart';
import '../../features/online_inquiries/presentation/providers/provider_contract.dart';

// Lista de providers globales para MultiProvider.
class AppProviders {
  static List<SingleChildWidget> get providers => [
    // Exponemos SttService para UI
    Provider<SttService>(
      create: (_) => inject.instance<SttService>(),
      lazy: false,
    ),
    ChangeNotifierProvider<SettingsService>(
      create: (_) {
        final settings = inject.instance<SettingsService>();
        settings.init();
        return settings;
      },
    ),
    ChangeNotifierProvider<IOnlineInquiriesProviderContract>(
      create: (_) => inject.instance<IOnlineInquiriesProviderContract>(),
    ),
  ];
}
