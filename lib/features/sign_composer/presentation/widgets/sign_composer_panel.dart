import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/sign_preview.dart';
import '../cubit/sign_composer_cubit.dart';
import '../cubit/sign_composer_state.dart';
import 'sign_action_row.dart';
import 'sign_coming_soon_panel.dart';
import 'sign_keyboard.dart';
import 'sign_mode_tabs.dart';
import 'sign_preview_panel.dart';
import 'sign_suggestion_chips.dart';
import 'sign_text_field.dart';

class SignComposerPanel extends StatelessWidget {
  const SignComposerPanel({
    super.key,
    required this.onClose,
    required this.onSend,
  });

  final VoidCallback onClose;
  final ValueChanged<SignPreview> onSend;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.composer,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onClose,
                    tooltip: 'İşaret oluşturucuyu kapat',
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              BlocSelector<
                SignComposerCubit,
                SignComposerState,
                SignComposerMode
              >(
                selector: (state) => state.mode,
                builder: (context, mode) => SignModeTabs(
                  selectedMode: mode,
                  onModeSelected: context.read<SignComposerCubit>().selectMode,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              BlocBuilder<SignComposerCubit, SignComposerState>(
                builder: (context, state) {
                  if (state.mode != SignComposerMode.textToSign) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: SignComingSoonPanel(
                        mode: state.mode,
                        onReturnToComposer: () => context
                            .read<SignComposerCubit>()
                            .selectMode(SignComposerMode.textToSign),
                      ),
                    );
                  }
                  final preview = state.preview;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 220),
                    child:
                        preview != null &&
                            (state.status == SignComposerStatus.previewReady ||
                                state.status == SignComposerStatus.sending)
                        ? SignPreviewPanel(
                            preview: preview,
                            isSending:
                                state.status == SignComposerStatus.sending,
                            onRegenerate: context
                                .read<SignComposerCubit>()
                                .regenerate,
                            onSend: () {
                              final cubit = context.read<SignComposerCubit>();
                              cubit.markSending();
                              onSend(preview);
                              cubit.reset();
                            },
                          )
                        : _EditingPanel(state: state),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditingPanel extends StatelessWidget {
  const _EditingPanel({required this.state});

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
