import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';

class MockChatRepository implements ChatRepository {
  const MockChatRepository();

  @override
  List<ChatMessage> initialMessages() {
    final now = DateTime.now();
    return [
      TextChatMessage(
        id: 'welcome-1',
        sentAt: now.subtract(const Duration(minutes: 8)),
        isMine: false,
        text: 'Merhaba! Bugün nasıl yardımcı olabilirim?',
      ),
      TextChatMessage(
        id: 'welcome-2',
        sentAt: now.subtract(const Duration(minutes: 6)),
        isMine: true,
        text: 'İşaret diliyle bir mesaj göndermek istiyorum.',
      ),
    ];
  }
}
