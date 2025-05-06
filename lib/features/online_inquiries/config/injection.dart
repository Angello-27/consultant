// lib/features/online_inquiries/config/injection.dart
import 'package:get_it/get_it.dart';

import '../data/datasources/remote_data_source.dart';
import '../domain/repositories/repository_interface.dart';
import '../domain/use_cases/use_case_contract.dart';
import '../presentation/providers/provider_contract.dart';

import '../data/datasources/http_data_source.dart';
import '../domain/repositories/repository.dart';
import '../domain/use_cases/use_case.dart';
import '../presentation/providers/provider.dart';

// Registra las dependencias del feature "Query Chat".
void registerQueryChatDependencies(GetIt instance, String baseUrl) {
  // Data Layer
  instance.registerLazySingleton<IOnlineInquiriesRemoteDataSource>(
    () => OnlineInquiriesRemoteDataSource(baseUrl: baseUrl),
  );

  // Repository Layer
  instance.registerLazySingleton<IOnlineInquiriesRepository>(
    () => OnlineInquiriesRepository(
      remote: instance<IOnlineInquiriesRemoteDataSource>(),
    ),
  );

  // Domain Layer
  instance.registerLazySingleton<IOnlineInquiriesUseCase>(
    () => OnlineInquiriesUseCase(
      repository: instance<IOnlineInquiriesRepository>(),
    ),
  );

  // Provider Layer
  instance.registerFactory<IOnlineInquiriesProviderContract>(
    () => OnlineInquiriesProvider(useCase: instance<IOnlineInquiriesUseCase>()),
  );
}
