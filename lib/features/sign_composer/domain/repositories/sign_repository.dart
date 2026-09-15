import '../entities/sign_asset.dart';
import '../entities/sign_preview.dart';

abstract interface class SignRepository {
  Future<List<SignAsset>> searchSigns(String query);

  Future<SignPreview> createPreview({
    required String text,
    required String targetLanguage,
  });
}
