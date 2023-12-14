part of 'find_restaurant_cubit.dart';

sealed class FindRestaurantState extends Equatable {
  const FindRestaurantState();

  @override
  List<Object> get props => [];
}

final class FindRestaurantInitial extends FindRestaurantState {}

final class FindRestaurantLoading extends FindRestaurantState {}

final class FindRestaurantSuccess extends FindRestaurantState {
  final FindRestaurant findRestaurants;

  const FindRestaurantSuccess({
    required this.findRestaurants,
  });

  @override
  List<Object> get props => [findRestaurants];
}

final class FindRestaurantFailed extends FindRestaurantState {
  final String error;

  const FindRestaurantFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
