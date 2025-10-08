import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shrine/app.dart';

void main() {
  testWidgets('Shrine app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ShrineApp());

    // Verify that the login page is shown by checking for the text fields.
    expect(find.text('Usuario'), findsOneWidget);
    expect(find.text('Contraseña'), findsOneWidget);
  });
}
