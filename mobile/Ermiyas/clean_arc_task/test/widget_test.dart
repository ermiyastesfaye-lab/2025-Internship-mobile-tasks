import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_7/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_7/features/product/presentation/pages/add_watch.dart';

void main() {
  testWidgets('Test Product Creation', (WidgetTester tester) async {
    // Build the widget tree with the AddWatch screen
    await tester.pumpWidget(MaterialApp(home: AddWatch()));

    // Find the input fields
    final nameField = find.byKey(Key('productNameField'));
    final categoryField = find.byKey(Key('productCategoryField'));
    final priceField = find.byKey(Key('productPriceField'));
    final descriptionField = find.byKey(Key('productDescriptionField'));
    final imageUrlField = find.byKey(Key('productImageUrlField'));

    final createButton = find.byType(ElevatedButton);

    // Simulate entering data into the fields
    await tester.enterText(nameField, 'Test Watch');
    await tester.enterText(categoryField, 'Luxury');
    await tester.enterText(priceField, '199.99');
    await tester.enterText(descriptionField, 'A beautiful luxury watch.');
    await tester.enterText(imageUrlField, 'http://example.com/watch.jpg');

    // Tap the button to submit the form
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    // Check if the product name and price appear on the screen after creation
    expect(find.text('Test Watch'), findsOneWidget);
    expect(find.text('199.99'), findsOneWidget);
  });
}
