import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../models/list_restaurant.dart';
import '../../services/restaurant_service.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit() : super(RestaurantInitial());

  Future<void> getListRestaurants() async {
    try {
      emit(RestaurantLoading());
      final restaurants =
          await RestaurantService().getListRestaurants(http.Client());
      emit(RestaurantSuccess(restaurants: restaurants));
    } on Exception catch (e) {
      emit(RestaurantFailed(error: e.toString()));
    }
  }
}
