import '../../domain/entities/sign_asset.dart';

class SignAssetModel {
  const SignAssetModel({
    required this.id,
    required this.label,
    required this.languageCode,
  });

  final String id;
  final String label;
  final String languageCode;

  SignAsset toDomain() => SignAsset(
    id: id,
    label: label,
    languageCode: languageCode,
    previewAssetPath: 'material://sign-language',
  );
}
