import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../sign_composer/domain/entities/sign_preview.dart';

class SignMessageMedia extends StatelessWidget {
  const SignMessageMedia({
    super.key,
    required this.preview,
    required this.signLabel,
  });

  final SignPreview preview;
  final String signLabel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 104,
        width: double.infinity,
        child: ColoredBox(
          color: AppColors.bubbleBackground,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _media(),
              Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _media() => switch (preview.sourceType) {
    SignPreviewSourceType.assetImage => Image.asset(
      preview.mediaSource,
      fit: BoxFit.contain,
      alignment: Alignment.center,
      cacheWidth: 480,
      semanticLabel: 'OrhApp karakteri, $signLabel işareti mesaj önizlemesi',
      errorBuilder: (_, _, _) => const _MediaFallback(),
    ),
    SignPreviewSourceType.networkVideo => const _MediaFallback(),
  };
}

class _MediaFallback extends StatelessWidget {
  const _MediaFallback();

  @override
  Widget build(BuildContext context) => const Center(
    child: Icon(
      Icons.sign_language_rounded,
      size: 34,
      color: AppColors.primary,
    ),
  );
}
