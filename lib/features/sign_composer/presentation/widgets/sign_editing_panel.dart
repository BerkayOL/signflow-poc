import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_spacing.dart';
import '../cubit/sign_composer_cubit.dart';
import '../cubit/sign_composer_state.dart';
import 'sign_action_row.dart';
import 'sign_keyboard.dart';
import 'sign_suggestion_chips.dart';
import 'sign_text_field.dart';

class SignEditingPanel extends StatelessWidget {
  const SignEditingPanel({super.key, required this.state});

  final SignComposerState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignComposerCubit>();
    final isLoading = state.status == SignComposerStatus.loadingPreview;
    return Column(
      key: const ValueKey('editing'),
      children: [
        SignTextField(
          text: state.text,
          onChanged: cubit.updateText,
          onSubmit: cubit.createPreview,
        ),
        const SizedBox(height: AppSpacing.sm),
        SignSuggestionChips(
          suggestions: state.suggestions,
          selected: state.selectedSigns,
          onSelected: cubit.toggleSuggestion,
        ),
        if (state.errorMessage case final message?) ...[
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFFFFB4AB), fontSize: 12),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        SignActionRow(
          targetLanguage: state.targetLanguage,
          onTargetLanguageSelected: cubit.selectTargetLanguage,
          isLoading: isLoading,
          onPreview: cubit.createPreview,
        ),
        const SizedBox(height: AppSpacing.sm),
        AbsorbPointer(
          absorbing: isLoading,
          child: AnimatedOpacity(
            opacity: isLoading ? .45 : 1,
            duration: const Duration(milliseconds: 150),
            child: SignKeyboard(
              onCharacter: cubit.appendCharacter,
              onBackspace: cubit.backspace,
              onSpace: cubit.addSpace,
            ),
          ),
        ),
      ],
    );
  }
}
