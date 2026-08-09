import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:whatsapp_ios_ui/main.dart';
import 'package:whatsapp_ios_ui/presentation/core/routes/routes_name.dart';
import 'package:whatsapp_ios_ui/presentation/screens/main_screen/main_screen.dart';
import 'package:whatsapp_ios_ui/widgets/custom_theme.dart';
import 'package:whatsapp_ios_ui/widgets/glass_surface.dart';

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

  testWidgets('uses iOS Liquid Glass navigation and chat filters',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.theme,
        home: const MainScreen(),
        onGenerateRoute: RouteNames.generateRoutes,
      ),
    );

    expect(find.byKey(const Key('ios-Chats-title')), findsOneWidget);
    expect(find.text('Ask Meta AI or Search'), findsOneWidget);
    expect(find.byKey(const Key('ios-tab-Updates')), findsOneWidget);
    expect(find.byKey(const Key('ios-tab-Calls')), findsOneWidget);
    expect(find.byKey(const Key('ios-tab-Communities')), findsOneWidget);
    expect(find.byKey(const Key('ios-tab-Chats')), findsOneWidget);
    expect(find.byKey(const Key('ios-tab-Settings')), findsOneWidget);
    expect(find.byType(GlassSurface), findsWidgets);

    await tester.tap(find.byKey(const Key('filter-Unread')));
    await tester.pump();
    expect(find.text('Weekend Crew'), findsOneWidget);
    expect(find.text('Martin Troff'), findsNothing);

    await tester.tap(find.byKey(const Key('ios-tab-Updates')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('ios-Updates-title')), findsOneWidget);
    expect(find.text('Status'), findsOneWidget);
    expect(find.text('Channels'), findsOneWidget);

    await tester.tap(find.byKey(const Key('ios-tab-Settings')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('ios-Settings-title')), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    expect(find.text('Privacy'), findsOneWidget);

    await tester.tap(find.byKey(const Key('ios-tab-Chats')));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('New chat'));
    await tester.pumpAndSettle();
    expect(find.text('New Chat'), findsOneWidget);

    await tester.tap(find.text('Martin Luther'));
    await tester.pumpAndSettle();
    expect(find.text('Martin Troff'), findsOneWidget);
    expect(find.text('Message'), findsOneWidget);
  });
}
