part of 'detail_restaurant_cubit.dart';

sealed class DetailRestaurantState extends Equatable {
  const DetailRestaurantState();

  @override
  List<Object> get props => [];
}

final class DetailRestaurantInitial extends DetailRestaurantState {}

final class DetailRestaurantLoading extends DetailRestaurantState {}

final class DetailRestaurantSuccess extends DetailRestaurantState {
  final DetailRestaurantModel detailRestaurant;

  const DetailRestaurantSuccess(this.detailRestaurant);

  @override
  List<Object> get props => [detailRestaurant];
}

final class DetailRestaurantFailed extends DetailRestaurantState {
  final String error;

  const DetailRestaurantFailed(this.error);

  @override
  List<Object> get props => [error];
}
