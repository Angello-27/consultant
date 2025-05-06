// lib/features/query_chat/config/injection.dart
import 'package:get_it/get_it.dart';

import '../../../shared/utils/tts_service.dart';

import '../data/datasources/query_remote_data_source.dart';
import '../domain/repositories/query_repository.dart';
import '../domain/use_cases/query_use_case.dart';

import '../data/datasources/query_remote_data_source_impl.dart';
import '../presentation/providers/query_provider.dart';
import '../domain/repositories/query_repository_impl.dart';
import '../domain/use_cases/query_use_case_impl.dart';

// Registra las dependencias del feature "Query Chat".
void registerQueryChatDependencies(GetIt instance, String baseUrl) {
  // Data Layer
  instance.registerLazySingleton<IQueryRemoteDataSource>(
    () => QueryRemoteDataSourceImpl(baseUrl: baseUrl),
  );
  instance.registerLazySingleton<IQueryRepository>(
    () => QueryRepositoryImpl(remote: instance<IQueryRemoteDataSource>()),
  );

  // Domain Layer
  instance.registerLazySingleton<IQueryUseCase>(
    () => QueryUseCaseImpl(repository: instance<IQueryRepository>()),
  );

  // Core / Utilidades
  instance.registerLazySingleton<TtsService>(() => TtsService()..initTts());

  // Presentation Layer
  instance.registerFactory<QueryProvider>(
    () => QueryProvider(
      queryUseCase: instance<IQueryUseCase>(),
      ttsService: instance<TtsService>(),
    ),
  );
}
