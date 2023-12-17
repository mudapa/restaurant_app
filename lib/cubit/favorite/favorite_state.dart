part of 'favorite_cubit.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteSuccess extends FavoriteState {
  final List<Restaurant> favoriteRestaurants;

  const FavoriteSuccess(this.favoriteRestaurants);

  @override
  List<Object> get props => [favoriteRestaurants];
}

final class FavoriteSuccessStatus extends FavoriteState {
  final bool isFavorite;

  const FavoriteSuccessStatus(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

final class FavoriteFailed extends FavoriteState {
  final String error;

  const FavoriteFailed(this.error);

  @override
  List<Object> get props => [error];
}
