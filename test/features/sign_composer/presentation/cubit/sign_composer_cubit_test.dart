import 'package:flutter_test/flutter_test.dart';
import 'package:imiapp/core/error/app_exception.dart';
import 'package:imiapp/features/sign_composer/domain/entities/sign_asset.dart';
import 'package:imiapp/features/sign_composer/domain/entities/sign_preview.dart';
import 'package:imiapp/features/sign_composer/domain/entities/sign_sequence.dart';
import 'package:imiapp/features/sign_composer/domain/repositories/sign_repository.dart';
import 'package:imiapp/features/sign_composer/domain/usecases/build_sign_preview.dart';
import 'package:imiapp/features/sign_composer/domain/usecases/search_signs.dart';
import 'package:imiapp/features/sign_composer/presentation/cubit/sign_composer_cubit.dart';
import 'package:imiapp/features/sign_composer/presentation/cubit/sign_composer_state.dart';

void main() {
  test('updates text input', () async {
    final cubit = _createCubit(_FakeSignRepository());
    await Future<void>.delayed(Duration.zero);

    cubit.updateText('MERHABA');

    expect(cubit.state.text, 'MERHABA');
    expect(cubit.state.status, SignComposerStatus.editing);
    await cubit.close();
  });

  test('selects visible future modes without running preview logic', () async {
    final repository = _FakeSignRepository();
    final cubit = _createCubit(repository);
    await Future<void>.delayed(Duration.zero);
    cubit.updateText('MERHABA');

    cubit.selectMode(SignComposerMode.signT9);

    expect(cubit.state.mode, SignComposerMode.signT9);
    expect(cubit.state.status, SignComposerStatus.editing);
    expect(cubit.state.text, 'MERHABA');
    expect(repository.previewCalls, 0);

    cubit.selectMode(SignComposerMode.tidToAsl);
    expect(cubit.state.mode, SignComposerMode.tidToAsl);
    await cubit.close();
  });

  test('emits loading then preview ready', () async {
    final cubit = _createCubit(_FakeSignRepository());
    await Future<void>.delayed(Duration.zero);
    cubit.updateText('MERHABA');
    final statuses = <SignComposerStatus>[];
    final subscription = cubit.stream.listen(
      (state) => statuses.add(state.status),
    );

    await cubit.createPreview();
    await Future<void>.delayed(Duration.zero);

    expect(
      statuses,
      containsAllInOrder([
        SignComposerStatus.loadingPreview,
        SignComposerStatus.previewReady,
      ]),
    );
    expect(cubit.state.preview?.sequence.sourceText, 'MERHABA');
    await subscription.cancel();
    await cubit.close();
  });

  test('maps repository failure to safe user-facing state', () async {
    final cubit = _createCubit(
      _FakeSignRepository(error: const AppException('unsupported_expression')),
    );
    await Future<void>.delayed(Duration.zero);
    cubit.updateText('DESTEKLENMEYEN');

    await cubit.createPreview();

    expect(cubit.state.status, SignComposerStatus.failure);
    expect(
      cubit.state.errorMessage,
      'Bu ifade için henüz bir işaret bulunamadı.',
    );
    expect(cubit.state.preview, isNull);
    await cubit.close();
  });

  test('rejects empty preview input without calling repository', () async {
    final repository = _FakeSignRepository();
    final cubit = _createCubit(repository);
    await Future<void>.delayed(Duration.zero);

    await cubit.createPreview();

    expect(cubit.state.status, SignComposerStatus.failure);
    expect(cubit.state.errorMessage, 'Önizlemek için bir metin yaz.');
    expect(repository.previewCalls, 0);
    await cubit.close();
  });
}

SignComposerCubit _createCubit(SignRepository repository) =>
    SignComposerCubit(BuildSignPreview(repository), SearchSigns(repository));

class _FakeSignRepository implements SignRepository {
  _FakeSignRepository({this.error});

  final Object? error;
  int previewCalls = 0;

  @override
  Future<SignPreview> createPreview({
    required String text,
    required String targetLanguage,
  }) async {
    previewCalls++;
    if (error case final failure?) throw failure;
    return SignPreview(
      sequence: SignSequence(
        sourceText: text,
        signs: const [
          SignAsset(id: 'merhaba', label: 'MERHABA', languageCode: 'TİD'),
        ],
        languageCode: targetLanguage,
      ),
      mediaSource: 'material://sign-language',
      sourceType: SignPreviewSourceType.placeholderAsset,
    );
  }

  @override
  Future<List<SignAsset>> searchSigns(String query) async => const [
    SignAsset(id: 'merhaba', label: 'MERHABA', languageCode: 'TİD'),
  ];
}
