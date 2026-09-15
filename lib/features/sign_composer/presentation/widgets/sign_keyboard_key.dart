import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class SignKeyboardKey extends StatelessWidget {
  const SignKeyboardKey({
    super.key,
    required this.label,
    required this.onPressed,
    this.flex = 1,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final int flex;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Material(
          color: Colors.white.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 38,
              child: Center(
                child: icon == null
                    ? Text(
                        label,
                        maxLines: 1,
                        style: const TextStyle(
                          color: AppColors.textOnDark,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Icon(icon, color: Colors.white, size: 19),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
