import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_7/model/watch.dart';
import 'package:task_7/features/product/presentation/pages/home.dart'; // Assuming the home screen contains the WatchGrid

void main() {
  testWidgets('Test Product Listing and Update', (WidgetTester tester) async {
    Watch testWatch1 = Watch(
      id: '1',
      name: 'Test Watch 1',
      category: 'Luxury',
      price: 199.99,
      description: 'A beautiful luxury watch.',
      imageUrl: 'http://example.com/watch1.jpg',
    );

    Watch testWatch2 = Watch(
      id: '2',
      name: 'Test Watch 2',
      category: 'Sport',
      price: 149.99,
      description: 'A sporty watch for active people.',
      imageUrl: 'http://example.com/watch2.jpg',
    );

    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> watchList = [];
    watchList.add(testWatch1.toJson());
    watchList.add(testWatch2.toJson());
    await prefs.setStringList('watch_list', watchList);

    await tester.pumpWidget(
      const MaterialApp(
        home: Home(),
      ),
    );

    await tester.pumpAndSettle();

    final cardWidgets = find.byType(Card);
    print('Found ${tester.widgetList(cardWidgets).length} card widgets');

    expect(cardWidgets, findsNWidgets(2));
    expect(find.text('Test Watch 1'), findsOneWidget);
    expect(find.text('Test Watch 2'), findsOneWidget);
  });
}
