import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sign composer presentation does not import the data layer', () {
    final presentation = Directory('lib/features/sign_composer/presentation');
    final dartFiles = presentation
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));

    for (final file in dartFiles) {
      final source = file.readAsStringSync();
      expect(
        source,
        isNot(contains('/data/')),
        reason: '${file.path} data katmanını doğrudan import etmemeli.',
      );
      expect(
        source,
        isNot(contains('SignGenerationProvider')),
        reason: '${file.path} provider implementation detayını bilmemeli.',
      );
    }
  });

  test('sign composer domain stays provider and framework agnostic', () {
    final domain = Directory('lib/features/sign_composer/domain');
    final dartFiles = domain
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));
    const forbiddenTerms = [
      '/data/',
      'package:flutter/',
      'SignGenerationProvider',
      'jobId',
      'polling',
      'webhook',
    ];

    for (final file in dartFiles) {
      final source = file.readAsStringSync();
      for (final term in forbiddenTerms) {
        expect(
          source,
          isNot(contains(term)),
          reason: '${file.path} domain sınırının dışında `$term` içeriyor.',
        );
      }
    }
  });
}
