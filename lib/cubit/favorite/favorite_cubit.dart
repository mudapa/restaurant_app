import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/restaurant_model.dart';
import '../../services/favorite_service.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  Future<bool> loadFavoriteStatus(Restaurant restaurant) async {
    try {
      emit(FavoriteLoading());
      final isFavorite = await FavoriteService().loadFavoriteStatus(restaurant);
      emit(FavoriteSuccessStatus(isFavorite));
      return isFavorite;
    } catch (e) {
      emit(FavoriteFailed(e.toString()));
      return false;
    }
  }

  void loadFavoriteRestaurants() async {
    try {
      emit(FavoriteLoading());
      final favorites = await FavoriteService().loadFavoriteRestaurants();
      emit(FavoriteSuccess(favorites));
    } catch (e) {
      emit(FavoriteFailed(e.toString()));
    }
  }

  void toggleFavorite(Restaurant restaurant) async {
    try {
      emit(FavoriteLoading());
      await FavoriteService().toggleFavorite(restaurant);
      loadFavoriteRestaurants();
    } catch (e) {
      emit(FavoriteFailed(e.toString()));
    }
  }

  void removeFavorite(Restaurant restaurant) async {
    try {
      emit(FavoriteLoading());
      await FavoriteService().removeFavorite(restaurant);
      loadFavoriteRestaurants();
    } catch (e) {
      emit(FavoriteFailed(e.toString()));
    }
  }
}
