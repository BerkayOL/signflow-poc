import '../../../../core/error/app_exception.dart';
import '../models/sign_asset_model.dart';
import '../models/sign_preview_model.dart';

class MockSignDataSource {
  const MockSignDataSource();

  static const waveAssetPath = 'assets/brand/orhapp_avatar_wave.jpg';
  static const okAssetPath = 'assets/brand/orhapp_avatar_ok.jpg';

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
            previewAssetPath: _assetForLabel(label),
          ),
        )
        .toList(growable: false);
  }

  Future<SignPreviewModel> createPreview(String text) async {
    await Future<void>.delayed(const Duration(milliseconds: 550));
    final words = text.trim().toUpperCase().split(RegExp(r'\s+'));
    if (words.contains('DESTEKLENMEYEN')) {
      throw const AppException('unsupported_expression');
    }
    if (words.contains('HATA')) {
      throw const AppException('preview_unavailable');
    }

    final signs = words
        .where((word) => word.isNotEmpty)
        .map(
          (word) => SignAssetModel(
            id: word.toLowerCase(),
            label: word,
            languageCode: 'TİD',
            previewAssetPath: _assetForLabel(word),
          ),
        )
        .toList(growable: false);

    return SignPreviewModel(signs: signs, assetPath: _assetForWords(words));
  }

  static String _assetForWords(List<String> words) {
    if (words.contains('TEŞEKKÜR')) return okAssetPath;
    return waveAssetPath;
  }

  static String _assetForLabel(String label) =>
      label == 'TEŞEKKÜR' ? okAssetPath : waveAssetPath;
}
