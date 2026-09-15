import '../../../../core/error/app_exception.dart';
import '../models/sign_asset_model.dart';

class MockSignDataSource {
  static const _labels = [
    'MERHABA',
    'NASIL',
    'SEN',
    'YARDIM',
    'YARIN',
    'GÖRÜŞÜRÜZ',
    'TEŞEKKÜR',
  ];

  Future<List<SignAssetModel>> searchSigns(String query) async {
    final normalized = query.trim().toUpperCase();
    return _labels
        .where((label) => normalized.isEmpty || label.contains(normalized))
        .map(
          (label) => SignAssetModel(
            id: label.toLowerCase(),
            label: label,
            languageCode: 'TİD',
          ),
        )
        .toList(growable: false);
  }

  Future<List<SignAssetModel>> createPreview(String text) async {
    await Future<void>.delayed(const Duration(milliseconds: 550));
    final words = text.trim().toUpperCase().split(RegExp(r'\s+'));
    if (words.contains('DESTEKLENMEYEN')) {
      throw const AppException('unsupported_expression');
    }
    if (words.contains('HATA')) {
      throw const AppException('preview_unavailable');
    }

    return words
        .where((word) => word.isNotEmpty)
        .map(
          (word) => SignAssetModel(
            id: word.toLowerCase(),
            label: word,
            languageCode: 'TİD',
          ),
        )
        .toList(growable: false);
  }
}
