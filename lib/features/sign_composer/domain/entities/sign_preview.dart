import 'package:equatable/equatable.dart';

import 'sign_sequence.dart';

enum SignPreviewSourceType { assetImage, remoteMedia }

class SignPreview extends Equatable {
  const SignPreview({
    required this.sequence,
    required this.mediaSource,
    required this.sourceType,
  });

  final SignSequence sequence;
  final String mediaSource;
  final SignPreviewSourceType sourceType;

  @override
  List<Object> get props => [sequence, mediaSource, sourceType];
}
