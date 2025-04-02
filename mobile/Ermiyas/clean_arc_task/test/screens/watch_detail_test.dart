// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:task_7/features/product/domain/entities/product.dart';
// import 'package:task_7/model/watch.dart';
// import 'package:task_7/features/product/presentation/pages/home.dart';
// import 'package:task_7/features/product/presentation/pages/watch_detail.dart';

// void main() {
//   testWidgets('Test Product Detail Page Navigation',
//       (WidgetTester tester) async {
//     // Prepare mock data for a Watch object
//     Product testWatch = Product(
//       id: '1',
//       name: 'Test Watch',
//       category: 'Luxury',
//       price: 199.99,
//       description: 'A beautiful luxury watch.',
//       imageUrl:
//           'https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//     );
//     SharedPreferences.setMockInitialValues({});
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> watchList = [testWatch.toJson()];
//     await prefs.setStringList('watch_list', watchList);

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Home(),
//         routes: {
//           '/watch_detail': (context) => WatchDetail(watch: testWatch),
//         },
//       ),
//     );

//     await tester.pumpAndSettle();

//     final watchTile = find.text('Test Watch');
//     await tester.tap(watchTile);
//     await tester.pumpAndSettle();

//     expect(find.byType(WatchDetail), findsOneWidget);

//     final backButton = find.byIcon(Icons.arrow_back_ios_new_rounded);
//     await tester.tap(backButton);
//     await tester.pumpAndSettle();

//     expect(find.byType(Home), findsOneWidget);
//   });
// }
