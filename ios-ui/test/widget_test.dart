import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:whatsapp_ios_ui/main.dart';
import 'package:whatsapp_ios_ui/presentation/core/routes/routes_name.dart';
import 'package:whatsapp_ios_ui/presentation/screens/main_screen/main_screen.dart';
import 'package:whatsapp_ios_ui/widgets/custom_theme.dart';
import 'package:whatsapp_ios_ui/widgets/iphone_device_frame.dart';

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

  testWidgets('uses Cupertino navigation and chat filters', (tester) async {
    await tester.pumpWidget(
      const CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.cupertino,
        home: MainScreen(),
        onGenerateRoute: RouteNames.generateRoutes,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('ios-聊天-title')), findsWidgets);
    expect(find.text('搜索'), findsOneWidget);
    expect(find.text('更新'), findsWidgets);
    expect(find.text('通话'), findsWidgets);
    expect(find.text('社区'), findsWidgets);
    expect(find.text('聊天'), findsWidgets);
    expect(find.text('自己'), findsWidgets);
    expect(find.text('允许完整联系人访问权限'), findsOneWidget);

    await tester.tap(find.byKey(const Key('filter-未读')));
    await tester.pump();
    expect(find.text('+852 5923 9971'), findsOneWidget);
    expect(find.text('WhatsApp'), findsNothing);

    await tester.tap(find.text('更新').last);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('ios-更新-title')), findsWidgets);
    expect(find.text('状态'), findsOneWidget);
    expect(find.text('频道'), findsOneWidget);

    await tester.tap(find.text('自己').last);
    await tester.pumpAndSettle();
    expect(find.text('心如止水'), findsOneWidget);
    expect(find.text('账户'), findsOneWidget);
    expect(find.text('隐私'), findsOneWidget);

    await tester.tap(find.text('聊天').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('ios-new-chat')));
    await tester.pumpAndSettle();
    expect(find.text('新聊天'), findsOneWidget);

    await tester.tap(find.text('Martin Luther'));
    await tester.pumpAndSettle();
    expect(find.text('+852 5923 9971'), findsOneWidget);
    expect(find.byKey(const Key('ios-jump-to-latest')), findsOneWidget);
    expect(find.text('hi'), findsOneWidget);

    await tester.tap(find.byKey(const Key('ios-chat-avatar')));
    await tester.pumpAndSettle();
    expect(find.text('联系人信息'), findsOneWidget);
    expect(find.text('新建联系人'), findsOneWidget);
    expect(find.text('媒体、链接和文档'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('加密'),
      300,
      scrollable: find.descendant(
        of: find.byKey(const Key('ios-contact-info-list')),
        matching: find.byType(Scrollable),
      ),
    );
    expect(find.text('加密'), findsOneWidget);
  });

  testWidgets('shows Apple iPhone chrome on a desktop-sized surface',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(1280, 900)),
        child: CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: MyTheme.cupertino,
          builder: (context, child) => IphoneExperience(
            forceFrame: true,
            child: child ?? const SizedBox.shrink(),
          ),
          home: const MainScreen(),
          onGenerateRoute: RouteNames.generateRoutes,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(IphoneExperience), findsOneWidget);
    expect(find.text('9:41'), findsOneWidget);
    expect(find.byKey(const Key('ios-聊天-title')), findsWidgets);
  });
}
