import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:restaurant_app/main.dart' as app;
import 'package:restaurant_app/ui/pages/main/favorite_page.dart';
import 'package:restaurant_app/ui/pages/main/home_page.dart';
import 'package:restaurant_app/ui/pages/main/setting_page.dart';

void main() {
  group('test app', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Tap ButtomNavigator', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('favorite_page_bottom_nav_item')));
      await tester.pumpAndSettle();
      expect(find.byType(FavoritePage), findsOneWidget);

      await tester.tap(find.byKey(const Key('setting_page_bottom_nav_item')));
      await tester.pumpAndSettle();
      expect(find.byType(SettingPage), findsOneWidget);

      await tester.tap(find.byKey(const Key('home_page_bottom_nav_item')));
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);

      await binding.traceAction(() async {
        await tester
            .tap(find.byKey(const Key('favorite_page_bottom_nav_item')));
        await tester.pumpAndSettle();
        expect(find.byType(FavoritePage), findsOneWidget);

        await tester.tap(find.byKey(const Key('setting_page_bottom_nav_item')));
        await tester.pumpAndSettle();
        expect(find.byType(SettingPage), findsOneWidget);

        await tester.tap(find.byKey(const Key('home_page_bottom_nav_item')));
        await tester.pumpAndSettle();
        expect(find.byType(HomePage), findsOneWidget);
      });
    });
  });
}
