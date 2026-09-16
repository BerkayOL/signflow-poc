import 'package:flutter_test/flutter_test.dart';
import 'package:imiapp/core/error/app_exception.dart';
import 'package:imiapp/features/sign_composer/data/datasources/sign_generation_datasource.dart';
import 'package:imiapp/features/sign_composer/data/providers/fake_sign_generation_provider.dart';

void main() {
  const dataSource = SignGenerationDataSource(
    FakeSignGenerationProvider(delay: Duration.zero),
  );

  test('maps provider failure to an application-safe error code', () async {
    await expectLater(
      dataSource.generatePreview(text: 'DESTEKLENMEYEN', targetLanguage: 'TİD'),
      throwsA(
        isA<AppException>().having(
          (error) => error.code,
          'code',
          'unsupported_expression',
        ),
      ),
    );
  });

  test('maps unknown provider failure to preview unavailable', () async {
    await expectLater(
      dataSource.generatePreview(text: 'HATA', targetLanguage: 'TİD'),
      throwsA(
        isA<AppException>().having(
          (error) => error.code,
          'code',
          'preview_unavailable',
        ),
      ),
    );
  });
}
