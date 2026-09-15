import 'package:equatable/equatable.dart';

import 'sign_asset.dart';

class SignSequence extends Equatable {
  const SignSequence({
    required this.sourceText,
    required this.signs,
    required this.languageCode,
  });

  final String sourceText;
  final List<SignAsset> signs;
  final String languageCode;

  @override
  List<Object> get props => [sourceText, signs, languageCode];
}
