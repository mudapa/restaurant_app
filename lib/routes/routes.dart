import 'package:flutter/widgets.dart';

import '../ui/pages/main/main_page.dart';
import '../ui/pages/splash_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
        '/': (context) => const SplashPage(),
        '/main': (context) => const MainPage(),
      };
}
