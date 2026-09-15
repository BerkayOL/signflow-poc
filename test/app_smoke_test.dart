import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imiapp/app/app.dart';
import 'package:imiapp/app/di/injector.dart';
import 'package:imiapp/app/theme/app_colors.dart';

void main() {
  setUpAll(configureDependencies);

  testWidgets('opens sign composer from chat', (tester) async {
    await tester.pumpWidget(const SignMessagingApp());
    await tester.pump();

    expect(find.text('Deniz'), findsOneWidget);
    expect(find.text('Mesaj yaz...'), findsOneWidget);

    await tester.tap(find.byTooltip('İşaret dili mesajı'));
    await tester.pumpAndSettle();

    expect(find.text('Metin → İşaret'), findsOneWidget);
    expect(find.text('Önizle'), findsOneWidget);
  });

  testWidgets('composer fits a compact Android viewport', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const SignMessagingApp());
    await tester.pump();

    await tester.tap(find.byTooltip('İşaret dili mesajı'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('boşluk'), findsOneWidget);
  });

  testWidgets('mode tabs and target language menu are interactive', (
    tester,
  ) async {
    await tester.pumpWidget(const SignMessagingApp());
    await tester.pump();
    await tester.tap(find.byTooltip('İşaret dili mesajı'));
    await tester.pumpAndSettle();

    expect(find.text('MERHABA'), findsOneWidget);
    var chipDecoration =
        tester
                .widget<AnimatedContainer>(
                  find
                      .ancestor(
                        of: find.text('MERHABA'),
                        matching: find.byType(AnimatedContainer),
                      )
                      .first,
                )
                .decoration
            as BoxDecoration;
    expect(chipDecoration.color, AppColors.composerSurface);

    await tester.tap(find.text('MERHABA'));
    await tester.pumpAndSettle();
    chipDecoration =
        tester
                .widget<AnimatedContainer>(
                  find
                      .ancestor(
                        of: find.text('MERHABA'),
                        matching: find.byType(AnimatedContainer),
                      )
                      .first,
                )
                .decoration
            as BoxDecoration;
    expect(chipDecoration.color, AppColors.success);

    await tester.tap(find.text('İşaret + T9').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('Kamera tabanlı işaret girişi'), findsOneWidget);

    await tester.tap(find.text('TİD → ASL').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('Diller arası işaret dönüşümü'), findsOneWidget);

    await tester.tap(find.text('Metin → İşaret').first);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Hedef işaret dilini seç'));
    await tester.pumpAndSettle();
    expect(find.text('Türk İşaret Dili (TİD)'), findsOneWidget);
    expect(find.text('ASL'), findsOneWidget);
  });

  testWidgets('custom keyboard switches between letters and numbers', (
    tester,
  ) async {
    await tester.pumpWidget(const SignMessagingApp());
    await tester.pump();
    await tester.tap(find.byTooltip('İşaret dili mesajı'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('123'));
    await tester.pump();
    expect(find.text('ABC'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('ABC'));
    await tester.pump();
    expect(find.text('Q'), findsOneWidget);
  });
}
