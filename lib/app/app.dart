import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/chat/domain/repositories/chat_repository.dart';
import '../features/chat/presentation/cubit/chat_cubit.dart';
import '../features/chat/presentation/pages/chat_page.dart';
import '../features/sign_composer/domain/usecases/build_sign_preview.dart';
import '../features/sign_composer/domain/usecases/search_signs.dart';
import '../features/sign_composer/presentation/cubit/sign_composer_cubit.dart';
import 'di/injector.dart';
import 'theme/app_theme.dart';

class SignMessagingApp extends StatelessWidget {
  const SignMessagingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ChatCubit(getIt<ChatRepository>())),
        BlocProvider(
          create: (_) => SignComposerCubit(
            getIt<BuildSignPreview>(),
            getIt<SearchSigns>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'İşaret Mesajları',
        theme: AppTheme.light,
        home: const ChatPage(),
      ),
    );
  }
}
