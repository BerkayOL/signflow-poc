import 'package:flutter_test/flutter_test.dart';
import 'package:imiapp/features/chat/data/repositories/mock_chat_repository.dart';
import 'package:imiapp/features/chat/domain/entities/chat_message.dart';
import 'package:imiapp/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:imiapp/features/sign_composer/domain/entities/sign_asset.dart';
import 'package:imiapp/features/sign_composer/domain/entities/sign_preview.dart';
import 'package:imiapp/features/sign_composer/domain/entities/sign_sequence.dart';

void main() {
  test('appends a typed sign message and closes composer', () {
    final cubit = ChatCubit(const MockChatRepository())..openSignComposer();
    const preview = SignPreview(
      sequence: SignSequence(
        sourceText: 'MERHABA',
        signs: [
          SignAsset(id: 'merhaba', label: 'MERHABA', languageCode: 'TİD'),
        ],
        languageCode: 'TİD',
      ),
      mediaSource: 'assets/brand/orhapp_avatar_wave.jpg',
      sourceType: SignPreviewSourceType.assetImage,
    );

    cubit.addSignMessage(preview);

    expect(cubit.state.messages.last, isA<SignChatMessage>());
    expect(cubit.state.isSignComposerOpen, isFalse);
    expect((cubit.state.messages.last as SignChatMessage).preview, preview);
    cubit.close();
  });
}
