import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../sign_composer/domain/entities/sign_preview.dart';
import '../../../sign_composer/presentation/cubit/sign_composer_cubit.dart';
import '../../../sign_composer/presentation/widgets/sign_composer_panel.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message_list.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChatAppBar(),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ChatMessageList(
                  messages: state.messages,
                  onReplay: (preview) => _replay(context, preview),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                child: state.isSignComposerOpen
                    ? SignComposerPanel(
                        onClose: () {
                          context.read<SignComposerCubit>().reset();
                          context.read<ChatCubit>().closeSignComposer();
                        },
                        onSend: context.read<ChatCubit>().addSignMessage,
                      )
                    : ChatInputBar(
                        onSend: context.read<ChatCubit>().addTextMessage,
                        onOpenSignComposer: context
                            .read<ChatCubit>()
                            .openSignComposer,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _replay(BuildContext context, SignPreview preview) {
    context.read<SignComposerCubit>().showExistingPreview(preview);
    context.read<ChatCubit>().openSignComposer();
  }
}
