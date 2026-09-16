import '../../domain/entities/sign_preview.dart';
import '../models/sign_asset_model.dart';
import '../models/sign_generation_request.dart';
import '../models/sign_preview_model.dart';
import 'sign_generation_provider.dart';

class FakeSignGenerationProvider implements SignGenerationProvider {
  const FakeSignGenerationProvider({this.delay = const Duration(seconds: 2)});

  static const waveAssetPath = 'assets/brand/orhapp_avatar_wave.jpg';
  static const okAssetPath = 'assets/brand/orhapp_avatar_ok.jpg';

  final Duration delay;

  @override
  Future<SignPreviewModel> generate(SignGenerationRequest request) async {
    await Future<void>.delayed(delay);
    final words = request.sourceText.trim().toUpperCase().split(RegExp(r'\s+'));
    if (words.contains('DESTEKLENMEYEN')) {
      throw const SignGenerationProviderException('unsupported_input');
    }
    if (words.contains('HATA')) {
      throw const SignGenerationProviderException('generation_failed');
    }

    final signs = words
        .where((word) => word.isNotEmpty)
        .map(
          (word) => SignAssetModel(
            id: word.toLowerCase(),
            label: word,
            languageCode: request.targetLanguage,
            previewAssetPath: _assetForLabel(word),
          ),
        )
        .toList(growable: false);

    return SignPreviewModel(
      signs: signs,
      mediaSource: _assetForWords(words),
      sourceType: SignPreviewSourceType.assetImage,
    );
  }

  static String _assetForWords(List<String> words) {
    if (words.contains('TEŞEKKÜR')) return okAssetPath;
    return waveAssetPath;
  }

  static String _assetForLabel(String label) =>
      label == 'TEŞEKKÜR' ? okAssetPath : waveAssetPath;
}
