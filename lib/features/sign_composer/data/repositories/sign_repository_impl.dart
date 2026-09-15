import '../../domain/entities/sign_asset.dart';
import '../../domain/entities/sign_preview.dart';
import '../../domain/repositories/sign_repository.dart';
import '../datasources/mock_sign_datasource.dart';

class SignRepositoryImpl implements SignRepository {
  const SignRepositoryImpl(this._dataSource);

  final MockSignDataSource _dataSource;

  @override
  Future<List<SignAsset>> searchSigns(String query) async {
    final models = await _dataSource.searchSigns(query);
    return models.map((model) => model.toDomain()).toList(growable: false);
  }

  @override
  Future<SignPreview> createPreview({
    required String text,
    required String targetLanguage,
  }) async {
    final model = await _dataSource.createPreview(text);
    return model.toDomain(
      sourceText: text.trim(),
      targetLanguage: targetLanguage,
    );
  }
}
