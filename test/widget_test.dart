import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:application_pedagogique/main.dart';

void main() {
  testWidgets('affiche le tableau de bord ClimLab', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() async => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const ClimLabApp());

    expect(find.text('ClimLab'), findsOneWidget);
    expect(find.text('Bonjour Léa,'), findsOneWidget);
    expect(find.text('Explorer les modules'), findsOneWidget);
    expect(find.text('Thermodynamique'), findsOneWidget);
    expect(find.text('Technologie'), findsOneWidget);
    expect(find.text('Maintenance préventive'), findsOneWidget);
    expect(find.text('Maintenance corrective'), findsOneWidget);
  });

  testWidgets('filtre les modules par niveau', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() async => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const ClimLabApp());

    await tester.tap(find.text('BTS MSF'));
    await tester.pump();

    expect(find.widgetWithText(ChoiceChip, 'BTS MSF'), findsOneWidget);
  });

  testWidgets('ouvre le chapitre 1 et valide le quiz', (
    WidgetTester tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() async => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const ClimLabApp());

    await tester.tap(find.text('Thermodynamique'));
    await tester.pumpAndSettle();

    expect(find.text('MODULE 01  /  CHAPITRE 01'), findsOneWidget);
    expect(find.text('La température décrit un état'), findsOneWidget);
    expect(
      find.text('Où va la chaleur dans un réfrigérateur ?'),
      findsOneWidget,
    );

    for (final answer in [
      'De 60 °C vers 20 °C',
      'La conduction',
      'Il devient moins dense et se déplace',
    ]) {
      await tester.ensureVisible(find.text(answer));
      await tester.tap(find.text(answer));
      await tester.pumpAndSettle();
    }

    expect(find.text('3 / 3 bonnes réponses'), findsOneWidget);
    await tester.ensureVisible(find.text('Valider le chapitre'));
    await tester.tap(find.text('Valider le chapitre'));
    await tester.pumpAndSettle();

    expect(find.text('Chapitre terminé'), findsOneWidget);
    expect(find.text('Chapitre 1 terminé. Bravo !'), findsOneWidget);
  });
}
