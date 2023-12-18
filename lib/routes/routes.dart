import 'package:flutter/widgets.dart';

import '../models/restaurant_model.dart';
import '../ui/pages/main/detail_page.dart';
import '../ui/pages/main/main_page.dart';
import '../ui/pages/splash_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
        '/': (context) => const SplashPage(),
        '/main': (context) => const MainPage(),
        '/detail_restaurant': (context) => DetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      };
}
