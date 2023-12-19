import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/routes/list_bloc_providers.dart';
import 'package:restaurant_app/ui/pages/main/main_page.dart';

Widget createWidgetForTesting() {
  return MultiBlocProvider(
    providers: ListBlocProviders.providers,
    child: const MaterialApp(
      home: MainPage(),
    ),
  );
}

void main() {
  group('Test Main Page', () {
    testWidgets('Tap Bottom Navigation Bar', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(createWidgetForTesting());

        await tester.tap(
          find.byKey(const Key('favorite_page_bottom_nav_item')),
        );

        await tester.tap(
          find.byKey(const Key('setting_page_bottom_nav_item')),
        );

        await tester.tap(
          find.byKey(const Key('home_page_bottom_nav_item')),
        );

        expect(
          find.byKey(const Key('home_page_bottom_nav_item')),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('favorite_page_bottom_nav_item')),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('setting_page_bottom_nav_item')),
          findsOneWidget,
        );
      });
    });

    testWidgets('Tap Floating Action Button', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(createWidgetForTesting());

        await tester.tap(
          find.byKey(const Key('search_icon')),
        );
      });
    });
  });
}
