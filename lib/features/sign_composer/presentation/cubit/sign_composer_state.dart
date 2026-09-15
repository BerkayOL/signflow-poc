import 'package:equatable/equatable.dart';

import '../../domain/entities/sign_asset.dart';
import '../../domain/entities/sign_preview.dart';

enum SignComposerMode { textToSign, signT9, tidToAsl }

enum SignComposerStatus {
  editing,
  loadingPreview,
  previewReady,
  sending,
  failure,
}

final class SignComposerState extends Equatable {
  const SignComposerState({
    this.mode = SignComposerMode.textToSign,
    this.status = SignComposerStatus.editing,
    this.text = '',
    this.targetLanguage = 'TİD',
    this.suggestions = const [],
    this.selectedSigns = const [],
    this.preview,
    this.errorMessage,
  });

  final SignComposerMode mode;
  final SignComposerStatus status;
  final String text;
  final String targetLanguage;
  final List<SignAsset> suggestions;
  final List<SignAsset> selectedSigns;
  final SignPreview? preview;
  final String? errorMessage;

  SignComposerState copyWith({
    SignComposerMode? mode,
    SignComposerStatus? status,
    String? text,
    String? targetLanguage,
    List<SignAsset>? suggestions,
    List<SignAsset>? selectedSigns,
    SignPreview? preview,
    bool clearPreview = false,
    String? errorMessage,
    bool clearError = false,
  }) => SignComposerState(
    mode: mode ?? this.mode,
    status: status ?? this.status,
    text: text ?? this.text,
    targetLanguage: targetLanguage ?? this.targetLanguage,
    suggestions: suggestions ?? this.suggestions,
    selectedSigns: selectedSigns ?? this.selectedSigns,
    preview: clearPreview ? null : preview ?? this.preview,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    mode,
    status,
    text,
    targetLanguage,
    suggestions,
    selectedSigns,
    preview,
    errorMessage,
  ];
}
