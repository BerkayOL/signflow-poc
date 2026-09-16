import '../../../../core/error/app_exception.dart';
import '../models/sign_generation_request.dart';
import '../models/sign_preview_model.dart';
import '../providers/sign_generation_provider.dart';

class SignGenerationDataSource {
  const SignGenerationDataSource(this._provider);

  final SignGenerationProvider _provider;

  Future<SignPreviewModel> generatePreview({
    required String text,
    required String targetLanguage,
  }) async {
    try {
      return await _provider.generate(
        SignGenerationRequest(sourceText: text, targetLanguage: targetLanguage),
      );
    } on SignGenerationProviderException catch (error) {
      final code = error.code == 'unsupported_input'
          ? 'unsupported_expression'
          : 'preview_unavailable';
      throw AppException(code);
    } catch (_) {
      throw const AppException('preview_unavailable');
    }
  }
}
