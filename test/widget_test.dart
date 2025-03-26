import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Add this if using Riverpod
import 'package:shoppping_cart/main.dart'; // Ensure correct import

void main() {
  testWidgets('Cart counter increments correctly', (WidgetTester tester) async {
    // Wrap in ProviderScope if using Riverpod
    await tester.pumpWidget(ProviderScope(child: MyApp()));

    // Verify the counter starts at 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
