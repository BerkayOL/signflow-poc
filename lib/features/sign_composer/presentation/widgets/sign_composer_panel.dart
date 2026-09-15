import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../domain/entities/sign_preview.dart';
import '../cubit/sign_composer_cubit.dart';
import '../cubit/sign_composer_state.dart';
import 'sign_coming_soon_panel.dart';
import 'sign_editing_panel.dart';
import 'sign_mode_tabs.dart';
import 'sign_preview_panel.dart';

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
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * .72,
        ),
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
                    onModeSelected: context
                        .read<SignComposerCubit>()
                        .selectMode,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Flexible(
                  child: SingleChildScrollView(
                    child: BlocBuilder<SignComposerCubit, SignComposerState>(
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
                                  (state.status ==
                                          SignComposerStatus.previewReady ||
                                      state.status ==
                                          SignComposerStatus.sending)
                              ? SignPreviewPanel(
                                  preview: preview,
                                  isSending:
                                      state.status ==
                                      SignComposerStatus.sending,
                                  onRegenerate: context
                                      .read<SignComposerCubit>()
                                      .regenerate,
                                  onSend: () {
                                    final cubit = context
                                        .read<SignComposerCubit>();
                                    cubit.markSending();
                                    onSend(preview);
                                    cubit.reset();
                                  },
                                )
                              : SignEditingPanel(state: state),
                        );
                      },
                    ),
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
