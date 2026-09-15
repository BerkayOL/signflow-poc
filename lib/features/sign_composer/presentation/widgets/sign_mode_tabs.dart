import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../cubit/sign_composer_state.dart';

class SignModeTabs extends StatelessWidget {
  const SignModeTabs({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
  });

  final SignComposerMode selectedMode;
  final ValueChanged<SignComposerMode> onModeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ModeTab(
            label: 'Metin → İşaret',
            isActive: selectedMode == SignComposerMode.textToSign,
            onTap: () => onModeSelected(SignComposerMode.textToSign),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _ModeTab(
            label: 'İşaret + T9',
            isActive: selectedMode == SignComposerMode.signT9,
            onTap: () => onModeSelected(SignComposerMode.signT9),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: _ModeTab(
            label: 'TİD → ASL',
            isActive: selectedMode == SignComposerMode.tidToAsl,
            onTap: () => onModeSelected(SignComposerMode.tidToAsl),
          ),
        ),
      ],
    );
  }
}

class _ModeTab extends StatelessWidget {
  const _ModeTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isActive,
      child: Material(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 40,
            child: Center(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.white60,
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
