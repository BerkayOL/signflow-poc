import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

class SignActionRow extends StatelessWidget {
  const SignActionRow({
    super.key,
    required this.targetLanguage,
    required this.onTargetLanguageSelected,
    required this.onPreview,
    required this.isLoading,
  });

  final String targetLanguage;
  final ValueChanged<String> onTargetLanguageSelected;
  final VoidCallback onPreview;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 340;
        return Row(
          children: [
            if (!compact) ...[
              const Text(
                'Şuraya çevir',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            _TargetLanguageMenu(
              selectedLanguage: targetLanguage,
              onSelected: onTargetLanguageSelected,
            ),
            const Spacer(),
            if (compact)
              IconButton.filled(
                onPressed: isLoading ? null : onPreview,
                tooltip: isLoading ? 'Hazırlanıyor' : 'Önizle',
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: AppColors.composer,
                ),
                icon: isLoading
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.visibility_outlined),
              )
            else
              FilledButton.icon(
                onPressed: isLoading ? null : onPreview,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: AppColors.composer,
                  minimumSize: const Size(104, 42),
                ),
                icon: isLoading
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.visibility_outlined, size: 18),
                label: Text(isLoading ? 'Hazırlanıyor' : 'Önizle'),
              ),
          ],
        );
      },
    );
  }
}

class _TargetLanguageMenu extends StatelessWidget {
  const _TargetLanguageMenu({
    required this.selectedLanguage,
    required this.onSelected,
  });

  final String selectedLanguage;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Hedef işaret dilini seç',
      onSelected: onSelected,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'TİD',
          child: Row(
            children: [
              const Expanded(child: Text('Türk İşaret Dili (TİD)')),
              if (selectedLanguage == 'TİD')
                const Icon(Icons.check_rounded, color: AppColors.primary),
            ],
          ),
        ),
        const PopupMenuItem(
          enabled: false,
          child: Row(
            children: [
              Expanded(child: Text('ASL')),
              Text('Yakında', style: TextStyle(color: AppColors.muted)),
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.composerSurface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              selectedLanguage,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(Icons.expand_more, color: Colors.white70, size: 16),
          ],
        ),
      ),
    );
  }
}
