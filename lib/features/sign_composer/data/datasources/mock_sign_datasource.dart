import '../models/sign_asset_model.dart';

class MockSignDataSource {
  const MockSignDataSource();

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
}
