import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/detail_restauraunt_model.dart';
import '../../services/restaurant_service.dart';

part 'detail_restaurant_state.dart';

class DetailRestaurantCubit extends Cubit<DetailRestaurantState> {
  DetailRestaurantCubit() : super(DetailRestaurantInitial());

  Future<void> getDetailRestaurant(String id) async {
    try {
      emit(DetailRestaurantLoading());
      final detailRestaurant =
          await RestaurantService().getDetailRestaurant(id);
      emit(DetailRestaurantSuccess(detailRestaurant));
    } on Exception catch (e) {
      emit(DetailRestaurantFailed(e.toString()));
    }
  }
}
