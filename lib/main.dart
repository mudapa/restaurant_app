import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'routes/list_bloc_providers.dart';
import 'routes/routes.dart';
import 'services/background_service.dart';
import 'shared/navigation.dart';
import 'shared/notification_helper.dart';
import 'shared/style.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
      providers: ListBlocProviders.providers,
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
        navigatorKey: navigatorKey,
        routes: AppRoutes.routes,
      ),
    );
  }
}
