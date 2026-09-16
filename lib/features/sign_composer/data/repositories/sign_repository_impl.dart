import '../../domain/entities/sign_asset.dart';
import '../../domain/entities/sign_preview.dart';
import '../../domain/repositories/sign_repository.dart';
import '../datasources/mock_sign_datasource.dart';
import '../datasources/sign_generation_datasource.dart';

class SignRepositoryImpl implements SignRepository {
  const SignRepositoryImpl(this._signDataSource, this._generationDataSource);

  final MockSignDataSource _signDataSource;
  final SignGenerationDataSource _generationDataSource;

  @override
  Future<List<SignAsset>> searchSigns(String query) async {
    final models = await _signDataSource.searchSigns(query);
    return models.map((model) => model.toDomain()).toList(growable: false);
  }

  @override
  Future<SignPreview> createPreview({
    required String text,
    required String targetLanguage,
  }) async {
    final model = await _generationDataSource.generatePreview(
      text: text,
      targetLanguage: targetLanguage,
    );
    return model.toDomain(
      sourceText: text.trim(),
      targetLanguage: targetLanguage,
    );
  }
}
