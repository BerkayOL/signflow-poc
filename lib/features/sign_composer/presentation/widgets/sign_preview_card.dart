import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/sign_preview.dart';

class SignPreviewCard extends StatelessWidget {
  const SignPreviewCard({super.key, required this.preview});

  final SignPreview preview;

  @override
  Widget build(BuildContext context) {
    final signs = preview.sequence.signs;
    final featuredLabel = signs.isEmpty ? 'TİD' : signs.first.label;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const LinearProgressIndicator(
              value: .38,
              minHeight: 4,
              color: AppColors.success,
              backgroundColor: Colors.white12,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ColoredBox(
                color: AppColors.bubbleBackground,
                child: _PreviewMedia(
                  preview: preview,
                  semanticLabel:
                      'OrhApp karakteri, $featuredLabel işareti önizlemesi',
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            featuredLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: signs
                .map(
                  (sign) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: .45),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      sign.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(growable: false),
          ),
        ],
      ),
    );
  }
}

class _PreviewMedia extends StatelessWidget {
  const _PreviewMedia({required this.preview, required this.semanticLabel});

  final SignPreview preview;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return switch (preview.sourceType) {
      SignPreviewSourceType.assetImage => Image.asset(
        preview.mediaSource,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        cacheWidth: 720,
        semanticLabel: semanticLabel,
        errorBuilder: (_, _, _) => const _MediaFallback(),
      ),
      SignPreviewSourceType.networkVideo => const _MediaFallback(),
    };
  }
}

class _MediaFallback extends StatelessWidget {
  const _MediaFallback();

  @override
  Widget build(BuildContext context) => const Center(
    child: Icon(
      Icons.sign_language_rounded,
      size: 46,
      color: AppColors.primary,
    ),
  );
}
