import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/detail/detail_restaurant_cubit.dart';
import 'cubit/favorite/favorite_cubit.dart';
import 'cubit/find/find_restaurant_cubit.dart';
import 'cubit/restaurant/restaurant_cubit.dart';
import 'cubit/review/review_cubit.dart';
import 'routes/routes.dart';
import 'shared/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurant App',
        theme: ThemeData(
          scaffoldBackgroundColor: lightBackgroundColor,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: blackColor,
            unselectedItemColor: greyColor,
            backgroundColor: whiteColor,
            elevation: 0,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: blueColor,
            shape: const CircleBorder(),
          ),
        ),
        routes: AppRoutes.routes,
      ),
    );
  }
}
