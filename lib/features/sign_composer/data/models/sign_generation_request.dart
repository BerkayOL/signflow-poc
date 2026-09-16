class SignGenerationRequest {
  const SignGenerationRequest({
    required this.sourceText,
    required this.targetLanguage,
  });

  final String sourceText;
  final String targetLanguage;
}
