import '../entities/sign_preview.dart';
import '../repositories/sign_repository.dart';

class BuildSignPreview {
  const BuildSignPreview(this._repository);

  final SignRepository _repository;

  Future<SignPreview> call({
    required String text,
    required String targetLanguage,
  }) => _repository.createPreview(text: text, targetLanguage: targetLanguage);
}
