import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../models/find_restaurant.dart';
import '../../services/restaurant_service.dart';

part 'find_restaurant_state.dart';

class FindRestaurantCubit extends Cubit<FindRestaurantState> {
  FindRestaurantCubit() : super(FindRestaurantInitial());

  Future<void> findRestaurant(String query) async {
    try {
      emit(FindRestaurantLoading());
      final restaurants =
          await RestaurantService().getSearchRestaurants(query, http.Client());
      emit(FindRestaurantSuccess(findRestaurants: restaurants));
    } on Exception catch (e) {
      emit(FindRestaurantFailed(error: e.toString()));
    }
  }
}
