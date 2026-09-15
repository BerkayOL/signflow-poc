import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_message.dart';

final class ChatState extends Equatable {
  const ChatState({required this.messages, this.isSignComposerOpen = false});

  final List<ChatMessage> messages;
  final bool isSignComposerOpen;

  ChatState copyWith({List<ChatMessage>? messages, bool? isSignComposerOpen}) =>
      ChatState(
        messages: messages ?? this.messages,
        isSignComposerOpen: isSignComposerOpen ?? this.isSignComposerOpen,
      );

  @override
  List<Object> get props => [messages, isSignComposerOpen];
}
