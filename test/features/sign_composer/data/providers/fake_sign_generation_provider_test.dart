import 'package:flutter_test/flutter_test.dart';
import 'package:imiapp/features/sign_composer/data/models/sign_generation_request.dart';
import 'package:imiapp/features/sign_composer/data/providers/fake_sign_generation_provider.dart';
import 'package:imiapp/features/sign_composer/data/providers/sign_generation_provider.dart';
import 'package:imiapp/features/sign_composer/domain/entities/sign_preview.dart';

void main() {
  const provider = FakeSignGenerationProvider(delay: Duration.zero);

  test('returns a completed branded generation result', () async {
    final result = await provider.generate(
      const SignGenerationRequest(sourceText: 'MERHABA', targetLanguage: 'TİD'),
    );

    expect(result.mediaSource, FakeSignGenerationProvider.waveAssetPath);
    expect(result.sourceType, SignPreviewSourceType.assetImage);
    expect(result.signs.single.label, 'MERHABA');
  });

  test('throws a controlled provider failure for unsupported input', () {
    expect(
      () => provider.generate(
        const SignGenerationRequest(
          sourceText: 'DESTEKLENMEYEN',
          targetLanguage: 'TİD',
        ),
      ),
      throwsA(
        isA<SignGenerationProviderException>().having(
          (error) => error.code,
          'code',
          'unsupported_input',
        ),
      ),
    );
  });

  test('uses a two second delay by default', () {
    const defaultProvider = FakeSignGenerationProvider();
    expect(defaultProvider.delay, const Duration(seconds: 2));
  });
}
