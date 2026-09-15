import 'package:equatable/equatable.dart';

import '../../../sign_composer/domain/entities/sign_preview.dart';

sealed class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.sentAt,
    required this.isMine,
  });

  final String id;
  final DateTime sentAt;
  final bool isMine;
}

final class TextChatMessage extends ChatMessage {
  const TextChatMessage({
    required super.id,
    required super.sentAt,
    required super.isMine,
    required this.text,
  });

  final String text;

  @override
  List<Object> get props => [id, sentAt, isMine, text];
}

final class SignChatMessage extends ChatMessage {
  const SignChatMessage({
    required super.id,
    required super.sentAt,
    required super.isMine,
    required this.preview,
  });

  final SignPreview preview;

  @override
  List<Object> get props => [id, sentAt, isMine, preview];
}
