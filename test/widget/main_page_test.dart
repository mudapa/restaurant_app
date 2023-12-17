import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/cubit/detail/detail_restaurant_cubit.dart';
import 'package:restaurant_app/cubit/favorite/favorite_cubit.dart';
import 'package:restaurant_app/cubit/find/find_restaurant_cubit.dart';
import 'package:restaurant_app/cubit/notification/notification_cubit.dart';
import 'package:restaurant_app/cubit/restaurant/restaurant_cubit.dart';
import 'package:restaurant_app/cubit/review/review_cubit.dart';
import 'package:restaurant_app/ui/pages/main/main_page.dart';

Widget createWidgetForTesting() {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => RestaurantCubit(),
      ),
      BlocProvider(
        create: (context) => FindRestaurantCubit(),
      ),
      BlocProvider(
        create: (context) => DetailRestaurantCubit(),
      ),
      BlocProvider(
        create: (context) => ReviewCubit(),
      ),
      BlocProvider(
        create: (context) => FavoriteCubit(),
      ),
      BlocProvider(
        create: (context) => NotificationCubit(),
      ),
    ],
    child: const MaterialApp(
      title: 'Restaurant App',
      home: MainPage(),
    ),
  );
}

void main() {
  group('widget test', () {
    testWidgets('test find icon', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(createWidgetForTesting());

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.home_filled), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byIcon(Icons.settings), findsOneWidget);
      });
    });

    testWidgets('test tap fab', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(createWidgetForTesting());

        await tester.tap(find.byKey(const Key('search_icon')));
      });
    });

    testWidgets('test tap bottom navigation', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(createWidgetForTesting());

        await tester.tap(find.byKey(const Key('bottom_nav_bar')));
      });
    });
  });
}
