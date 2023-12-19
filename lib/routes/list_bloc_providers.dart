import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../cubit/detail/detail_restaurant_cubit.dart';
import '../cubit/favorite/favorite_cubit.dart';
import '../cubit/find/find_restaurant_cubit.dart';
import '../cubit/notification/notification_cubit.dart';
import '../cubit/restaurant/restaurant_cubit.dart';
import '../cubit/review/review_cubit.dart';

class ListBlocProviders {
  static List<SingleChildWidget> providers = [
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
  ];
}
