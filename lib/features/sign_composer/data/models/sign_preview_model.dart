import '../../domain/entities/sign_preview.dart';
import '../../domain/entities/sign_sequence.dart';
import 'sign_asset_model.dart';

class SignPreviewModel {
  const SignPreviewModel({required this.signs, required this.assetPath});

  final List<SignAssetModel> signs;
  final String assetPath;

  SignPreview toDomain({
    required String sourceText,
    required String targetLanguage,
  }) => SignPreview(
    sequence: SignSequence(
      sourceText: sourceText,
      signs: signs.map((model) => model.toDomain()).toList(growable: false),
      languageCode: targetLanguage,
    ),
    mediaSource: assetPath,
    sourceType: SignPreviewSourceType.assetImage,
  );
}
