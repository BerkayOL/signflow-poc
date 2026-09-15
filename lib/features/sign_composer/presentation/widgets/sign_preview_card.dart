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
          Container(
            width: 88,
            height: 88,
            decoration: const BoxDecoration(
              color: AppColors.composerSurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.sign_language_rounded,
              size: 46,
              color: Colors.white,
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
