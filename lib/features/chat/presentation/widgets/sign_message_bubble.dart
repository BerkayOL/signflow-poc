import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/chat_message.dart';
import 'sign_message_media.dart';

class SignMessageBubble extends StatelessWidget {
  const SignMessageBubble({
    super.key,
    required this.message,
    required this.onReplay,
  });

  final SignChatMessage message;
  final VoidCallback onReplay;

  @override
  Widget build(BuildContext context) {
    final sequence = message.preview.sequence;
    final time =
        '${message.sentAt.hour.toString().padLeft(2, '0')}:'
        '${message.sentAt.minute.toString().padLeft(2, '0')}';
    return Align(
      alignment: Alignment.centerRight,
      child: Semantics(
        button: true,
        label: 'İşaret dili mesajını tekrar oynat',
        child: InkWell(
          onTap: onReplay,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 270,
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.composerSurface, AppColors.composer],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x241C184A),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _Badge(label: sequence.languageCode),
                    const Spacer(),
                    const Icon(
                      Icons.graphic_eq_rounded,
                      color: AppColors.success,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                SignMessageMedia(
                  preview: message.preview,
                  signLabel: sequence.signs.isEmpty
                      ? sequence.languageCode
                      : sequence.signs.first.label,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  sequence.signs.map((sign) => sign.label).join('  ·  '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .4,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    time,
                    style: const TextStyle(fontSize: 10, color: Colors.white60),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xs,
    ),
    decoration: BoxDecoration(
      color: AppColors.success,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: AppColors.composer,
      ),
    ),
  );
}
