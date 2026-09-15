import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/sign_preview.dart';
import 'sign_preview_card.dart';

class SignPreviewPanel extends StatelessWidget {
  const SignPreviewPanel({
    super.key,
    required this.preview,
    required this.onRegenerate,
    required this.onSend,
    required this.isSending,
  });

  final SignPreview preview;
  final VoidCallback onRegenerate;
  final VoidCallback onSend;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('preview'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.visibility_outlined,
              color: AppColors.success,
              size: 18,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'ÖNİZLE · ${preview.sequence.languageCode}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SignPreviewCard(preview: preview),
        const SizedBox(height: AppSpacing.sm),
        const Text(
          'Temsili önizleme · Gerçek TİD medya üretimi sonraki aşamada bağlanacak.',
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            TextButton.icon(
              onPressed: isSending ? null : onRegenerate,
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Tekrar oluştur'),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: isSending ? null : onSend,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: AppColors.composer,
              ),
              icon: isSending
                  ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send_rounded, size: 18),
              label: const Text('Gönder'),
            ),
          ],
        ),
      ],
    );
  }
}
