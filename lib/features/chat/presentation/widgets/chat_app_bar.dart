import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      toolbarHeight: preferredSize.height,
      titleSpacing: AppSpacing.lg,
      title: const Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.bubbleBackground,
            child: Icon(Icons.person_rounded, color: AppColors.primary),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Deniz', style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox.square(dimension: 7),
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Text(
                      'Çevrimiçi',
                      style: TextStyle(fontSize: 12, color: AppColors.muted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: const [SizedBox(width: AppSpacing.sm)],
    );
  }
}
