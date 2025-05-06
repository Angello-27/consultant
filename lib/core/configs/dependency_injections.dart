import 'package:get_it/get_it.dart';
import '../../data/datasources/query_api_client.dart';
import '../../data/repositories/query_repository.dart';
import '../../features/domain/use_cases/query_use_case.dart';
import '../../features/presentation/providers/query_provider.dart';
import 'app_config.dart';
import '../../core/utils/tts_service.dart'; // Asegúrate de que la ruta sea la correcta

final instance = GetIt.instance;

void setupDependencies() {
  // Data Layer
  instance.registerLazySingleton(
    () => QueryApiClient(baseUrl: AppConfig.serverUrl),
  );
  instance.registerLazySingleton(
    () => QueryRepository(apiClient: instance<QueryApiClient>()),
  );

  // Domain Layer
  instance.registerLazySingleton(
    () => QueryUseCase(repository: instance<QueryRepository>()),
  );

  // Core / Utilidades: Inyectar el TtsService e inicializarlo
  instance.registerLazySingleton<TtsService>(() => TtsService()..initTts());

  // Presentation Layer
  // Registro del QueryProvider para ser utilizado por Provider en la UI,
  // inyectando tanto el QueryUseCase como el TtsService.
  instance.registerFactory(
    () => QueryProvider(
      queryUseCase: instance<QueryUseCase>(),
      ttsService: instance<TtsService>(),
    ),
  );
}
