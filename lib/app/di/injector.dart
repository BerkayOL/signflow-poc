import 'package:get_it/get_it.dart';

import '../../features/chat/data/repositories/mock_chat_repository.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/sign_composer/data/datasources/mock_sign_datasource.dart';
import '../../features/sign_composer/data/datasources/sign_generation_datasource.dart';
import '../../features/sign_composer/data/providers/fake_sign_generation_provider.dart';
import '../../features/sign_composer/data/providers/sign_generation_provider.dart';
import '../../features/sign_composer/data/repositories/sign_repository_impl.dart';
import '../../features/sign_composer/domain/repositories/sign_repository.dart';
import '../../features/sign_composer/domain/usecases/build_sign_preview.dart';
import '../../features/sign_composer/domain/usecases/search_signs.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt
    ..registerLazySingleton<ChatRepository>(MockChatRepository.new)
    ..registerLazySingleton(MockSignDataSource.new)
    ..registerLazySingleton<SignGenerationProvider>(
      FakeSignGenerationProvider.new,
    )
    ..registerLazySingleton(
      () => SignGenerationDataSource(getIt<SignGenerationProvider>()),
    )
    ..registerLazySingleton<SignRepository>(
      () => SignRepositoryImpl(
        getIt<MockSignDataSource>(),
        getIt<SignGenerationDataSource>(),
      ),
    )
    ..registerLazySingleton(() => BuildSignPreview(getIt<SignRepository>()))
    ..registerLazySingleton(() => SearchSigns(getIt<SignRepository>()));
}
