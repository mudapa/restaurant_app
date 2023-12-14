part of 'restaurant_cubit.dart';

sealed class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

final class RestaurantInitial extends RestaurantState {}

final class RestaurantLoading extends RestaurantState {}

final class RestaurantSuccess extends RestaurantState {
  final ListRestaurant restaurants;

  const RestaurantSuccess({
    required this.restaurants,
  });

  @override
  List<Object> get props => [restaurants];
}

final class RestaurantFailed extends RestaurantState {
  final String error;

  const RestaurantFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
