import 'package:equatable/equatable.dart';

class SignAsset extends Equatable {
  const SignAsset({
    required this.id,
    required this.label,
    required this.languageCode,
    this.previewAssetPath,
    this.previewUrl,
  });

  final String id;
  final String label;
  final String languageCode;
  final String? previewAssetPath;
  final String? previewUrl;

  @override
  List<Object?> get props => [
    id,
    label,
    languageCode,
    previewAssetPath,
    previewUrl,
  ];
}
