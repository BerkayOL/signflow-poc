import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../sign_composer/domain/entities/sign_preview.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(ChatRepository repository)
    : super(ChatState(messages: repository.initialMessages()));

  void openSignComposer() {
    emit(state.copyWith(isSignComposerOpen: true));
  }

  void closeSignComposer() {
    emit(state.copyWith(isSignComposerOpen: false));
  }

  void addTextMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    emit(
      state.copyWith(
        messages: [
          ...state.messages,
          TextChatMessage(
            id: 'text-${DateTime.now().microsecondsSinceEpoch}',
            sentAt: DateTime.now(),
            isMine: true,
            text: trimmed,
          ),
        ],
      ),
    );
  }

  void addSignMessage(SignPreview preview) {
    emit(
      state.copyWith(
        messages: [
          ...state.messages,
          SignChatMessage(
            id: 'sign-${DateTime.now().microsecondsSinceEpoch}',
            sentAt: DateTime.now(),
            isMine: true,
            preview: preview,
          ),
        ],
        isSignComposerOpen: false,
      ),
    );
  }
}
