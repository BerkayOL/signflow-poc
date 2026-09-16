import 'package:flutter_test/flutter_test.dart';
import 'package:imiapp/features/sign_composer/data/datasources/mock_sign_datasource.dart';
import 'package:imiapp/features/sign_composer/data/datasources/sign_generation_datasource.dart';
import 'package:imiapp/features/sign_composer/data/providers/fake_sign_generation_provider.dart';
import 'package:imiapp/features/sign_composer/data/repositories/sign_repository_impl.dart';
import 'package:imiapp/features/sign_composer/domain/entities/sign_preview.dart';

void main() {
  const repository = SignRepositoryImpl(
    MockSignDataSource(),
    SignGenerationDataSource(FakeSignGenerationProvider(delay: Duration.zero)),
  );

  test('maps MERHABA preview to the waving OrhApp asset', () async {
    final preview = await repository.createPreview(
      text: 'MERHABA',
      targetLanguage: 'TİD',
    );

    expect(preview.sourceType, SignPreviewSourceType.assetImage);
    expect(preview.mediaSource, FakeSignGenerationProvider.waveAssetPath);
    expect(
      preview.sequence.signs.single.previewAssetPath,
      FakeSignGenerationProvider.waveAssetPath,
    );
  });

  test('maps TEŞEKKÜR preview to the OK OrhApp asset', () async {
    final preview = await repository.createPreview(
      text: 'TEŞEKKÜR',
      targetLanguage: 'TİD',
    );

    expect(preview.mediaSource, FakeSignGenerationProvider.okAssetPath);
  });
}
