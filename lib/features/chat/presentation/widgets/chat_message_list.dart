import 'package:flutter/material.dart';

import '../../../../app/theme/app_spacing.dart';
import '../../../sign_composer/domain/entities/sign_preview.dart';
import '../../domain/entities/chat_message.dart';
import 'sign_message_bubble.dart';
import 'text_message_bubble.dart';

class ChatMessageList extends StatelessWidget {
  const ChatMessageList({
    super.key,
    required this.messages,
    required this.onReplay,
  });

  final List<ChatMessage> messages;
  final ValueChanged<SignPreview> onReplay;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[messages.length - index - 1];
        return switch (message) {
          TextChatMessage() => TextMessageBubble(message: message),
          SignChatMessage() => SignMessageBubble(
            message: message,
            onReplay: () => onReplay(message.preview),
          ),
        };
      },
    );
  }
}
