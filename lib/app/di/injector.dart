import 'package:get_it/get_it.dart';

import '../../features/chat/data/repositories/mock_chat_repository.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/sign_composer/data/datasources/mock_sign_datasource.dart';
import '../../features/sign_composer/data/repositories/sign_repository_impl.dart';
import '../../features/sign_composer/domain/repositories/sign_repository.dart';
import '../../features/sign_composer/domain/usecases/build_sign_preview.dart';
import '../../features/sign_composer/domain/usecases/search_signs.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt
    ..registerLazySingleton<ChatRepository>(MockChatRepository.new)
    ..registerLazySingleton(MockSignDataSource.new)
    ..registerLazySingleton<SignRepository>(
      () => SignRepositoryImpl(getIt<MockSignDataSource>()),
    )
    ..registerLazySingleton(() => BuildSignPreview(getIt<SignRepository>()))
    ..registerLazySingleton(() => SearchSigns(getIt<SignRepository>()));
}
