import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_7/pages/add_watch.dart';

void main() {
  testWidgets('Test Product Creation', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddWatch()));

    final nameField = find.byKey(
      const Key('nameField'),
    );
    final categoryField = find.byKey(
      const Key('categoryField'),
    );
    final priceField = find.byKey(const Key('priceField'));
    final descriptionField = find.byKey(
      const Key('descriptionField'),
    );
    final imageUrlField = find.byKey(
      const Key('imageUrlField'),
    );

    final createButton = find.byType(ElevatedButton);

    await tester.enterText(nameField, 'Test Watch');
    await tester.enterText(categoryField, 'Luxury');
    await tester.enterText(priceField, '199.99');
    await tester.enterText(descriptionField, 'A beautiful luxury watch.');
    await tester.enterText(imageUrlField, 'http://example.com/watch.jpg');

    await tester.tap(createButton);
    await tester.pumpAndSettle();

    expect(find.text('Test Watch'), findsOneWidget);
    expect(find.text('199.99'), findsOneWidget);
  });
}
