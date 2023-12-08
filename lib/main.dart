import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes/routes.dart';
import 'shared/style.dart';

void main() {
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
    return MaterialApp(
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
      ),
      routes: AppRoutes.routes,
    );
  }
}
