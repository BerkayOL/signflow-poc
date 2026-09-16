import '../models/sign_generation_request.dart';
import '../models/sign_preview_model.dart';

abstract interface class SignGenerationProvider {
  Future<SignPreviewModel> generate(SignGenerationRequest request);
}

class SignGenerationProviderException implements Exception {
  const SignGenerationProviderException(this.code);

  final String code;
}
