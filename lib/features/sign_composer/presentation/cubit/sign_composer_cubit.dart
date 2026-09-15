import 'package:characters/characters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/app_exception.dart';
import '../../domain/entities/sign_asset.dart';
import '../../domain/entities/sign_preview.dart';
import '../../domain/usecases/build_sign_preview.dart';
import '../../domain/usecases/search_signs.dart';
import 'sign_composer_state.dart';

class SignComposerCubit extends Cubit<SignComposerState> {
  SignComposerCubit(this._buildPreview, this._searchSigns)
    : super(const SignComposerState()) {
    loadSuggestions();
  }

  final BuildSignPreview _buildPreview;
  final SearchSigns _searchSigns;

  void selectMode(SignComposerMode mode) {
    if (mode == state.mode) return;
    emit(
      state.copyWith(
        mode: mode,
        status: SignComposerStatus.editing,
        clearPreview: true,
        clearError: true,
      ),
    );
  }

  void selectTargetLanguage(String languageCode) {
    if (languageCode != 'TİD' || languageCode == state.targetLanguage) return;
    emit(
      state.copyWith(
        targetLanguage: languageCode,
        status: SignComposerStatus.editing,
        clearPreview: true,
        clearError: true,
      ),
    );
  }

  Future<void> loadSuggestions() async {
    final suggestions = await _searchSigns('');
    if (!isClosed) emit(state.copyWith(suggestions: suggestions));
  }

  void updateText(String text) {
    emit(
      state.copyWith(
        text: text,
        status: SignComposerStatus.editing,
        clearPreview: true,
        clearError: true,
      ),
    );
  }

  void appendCharacter(String character) =>
      updateText('${state.text}$character');

  void addSpace() {
    if (state.text.isNotEmpty && !state.text.endsWith(' ')) {
      updateText('${state.text} ');
    }
  }

  void backspace() {
    if (state.text.isEmpty) return;
    updateText(state.text.characters.skipLast(1).toString());
  }

  void toggleSuggestion(SignAsset sign) {
    final isSelected = state.selectedSigns.contains(sign);
    final selected = isSelected
        ? state.selectedSigns.where((item) => item != sign).toList()
        : [...state.selectedSigns, sign];
    emit(
      state.copyWith(
        selectedSigns: selected,
        text: selected.map((item) => item.label).join(' '),
        status: SignComposerStatus.editing,
        clearPreview: true,
        clearError: true,
      ),
    );
  }

  Future<void> createPreview() async {
    if (state.text.trim().isEmpty) {
      emit(
        state.copyWith(
          status: SignComposerStatus.failure,
          errorMessage: 'Önizlemek için bir metin yaz.',
          clearPreview: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SignComposerStatus.loadingPreview,
        clearError: true,
      ),
    );
    try {
      final preview = await _buildPreview(
        text: state.text,
        targetLanguage: state.targetLanguage,
      );
      if (!isClosed) {
        emit(
          state.copyWith(
            status: SignComposerStatus.previewReady,
            preview: preview,
          ),
        );
      }
    } on AppException catch (error) {
      if (!isClosed) _emitFailure(error.code);
    } catch (_) {
      if (!isClosed) _emitFailure('preview_unavailable');
    }
  }

  void regenerate() => updateText(state.text);

  void markSending() =>
      emit(state.copyWith(status: SignComposerStatus.sending));

  void showExistingPreview(SignPreview preview) {
    emit(
      state.copyWith(
        text: preview.sequence.sourceText,
        selectedSigns: preview.sequence.signs,
        preview: preview,
        status: SignComposerStatus.previewReady,
        clearError: true,
      ),
    );
  }

  void reset() => emit(SignComposerState(suggestions: state.suggestions));

  void _emitFailure(String code) {
    final message = code == 'unsupported_expression'
        ? 'Bu ifade için henüz bir işaret bulunamadı.'
        : 'Önizleme oluşturulamadı. Tekrar deneyin.';
    emit(
      state.copyWith(
        status: SignComposerStatus.failure,
        errorMessage: message,
        clearPreview: true,
      ),
    );
  }
}
