import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:whatsapp_clone/main.dart';
import 'package:whatsapp_clone/presentation/screens/main_screen/main_screen.dart';
import 'package:whatsapp_clone/widgets/custom_theme.dart';

void main() {
  testWidgets('shows the current Meta-branded welcome flow', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('from'), findsOneWidget);
    expect(find.text('Meta'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pumpAndSettle();
    expect(find.text('Welcome to WhatsApp'), findsOneWidget);
    expect(find.text('Agree and continue'), findsOneWidget);
  });

  testWidgets('uses Android bottom navigation and chat filters',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.theme,
        home: const MainScreen(),
      ),
    );

    expect(find.text('WhatsApp'), findsOneWidget);
    expect(find.text('Ask Meta AI or Search'), findsOneWidget);
    expect(find.text('Chats'), findsOneWidget);
    expect(find.text('Updates'), findsOneWidget);
    expect(find.text('Communities'), findsOneWidget);
    expect(find.text('Calls'), findsOneWidget);

    await tester.tap(find.byKey(const Key('filter-Unread')));
    await tester.pump();
    expect(find.text('Weekend Crew'), findsOneWidget);
    expect(find.text('Martin Troff'), findsNothing);

    await tester.tap(find.text('Updates'));
    await tester.pumpAndSettle();
    expect(find.text('Status'), findsOneWidget);
    expect(find.text('Channels'), findsOneWidget);
  });
}
