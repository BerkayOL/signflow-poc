import '../../domain/entities/sign_preview.dart';
import '../../domain/entities/sign_sequence.dart';
import 'sign_asset_model.dart';

class SignPreviewModel {
  const SignPreviewModel({
    required this.signs,
    required this.mediaSource,
    required this.sourceType,
  });

  final List<SignAssetModel> signs;
  final String mediaSource;
  final SignPreviewSourceType sourceType;

  SignPreview toDomain({
    required String sourceText,
    required String targetLanguage,
  }) => SignPreview(
    sequence: SignSequence(
      sourceText: sourceText,
      signs: signs.map((model) => model.toDomain()).toList(growable: false),
      languageCode: targetLanguage,
    ),
    mediaSource: mediaSource,
    sourceType: sourceType,
  );
}
