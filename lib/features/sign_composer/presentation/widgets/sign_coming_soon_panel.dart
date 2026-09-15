import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../cubit/sign_composer_state.dart';

class SignComingSoonPanel extends StatelessWidget {
  const SignComingSoonPanel({
    super.key,
    required this.mode,
    required this.onReturnToComposer,
  });

  final SignComposerMode mode;
  final VoidCallback onReturnToComposer;

  @override
  Widget build(BuildContext context) {
    final (title, description, icon) = switch (mode) {
      SignComposerMode.signT9 => (
        'İşaret + T9',
        'Kamera tabanlı işaret girişi ve T9 önerileri sonraki aşamada etkinleştirilecek.',
        Icons.gesture_rounded,
      ),
      SignComposerMode.tidToAsl => (
        'TİD → ASL',
        'Diller arası işaret dönüşümü gerçek servis entegrasyonuyla etkinleştirilecek.',
        Icons.translate_rounded,
      ),
      SignComposerMode.textToSign => (
        'Metin → İşaret',
        '',
        Icons.sign_language_rounded,
      ),
    };

    return Container(
      key: ValueKey(mode),
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.composerSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.primary,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white60, height: 1.4),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: onReturnToComposer,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white30),
            ),
            icon: const Icon(Icons.arrow_back_rounded, size: 18),
            label: const Text('Metin moduna dön'),
          ),
        ],
      ),
    );
  }
}
