import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/sign_asset.dart';

class SignSuggestionChips extends StatelessWidget {
  const SignSuggestionChips({
    super.key,
    required this.suggestions,
    required this.selected,
    required this.onSelected,
  });

  final List<SignAsset> suggestions;
  final List<SignAsset> selected;
  final ValueChanged<SignAsset> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: suggestions.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final sign = suggestions[index];
          final isSelected = selected.contains(sign);
          return Semantics(
            button: true,
            selected: isSelected,
            label: sign.label,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(9),
              child: InkWell(
                onTap: () => onSelected(sign),
                borderRadius: BorderRadius.circular(9),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.success
                        : AppColors.composerSurface,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: isSelected ? AppColors.success : Colors.white24,
                    ),
                  ),
                  child: Text(
                    sign.label,
                    style: TextStyle(
                      color: isSelected ? AppColors.composer : Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
