import '../entities/chat_message.dart';

abstract interface class ChatRepository {
  List<ChatMessage> initialMessages();
}
