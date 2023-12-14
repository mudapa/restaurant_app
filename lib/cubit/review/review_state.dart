part of 'review_cubit.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

final class ReviewInitial extends ReviewState {}

final class ReviewLoading extends ReviewState {}

final class ReviewSuccess extends ReviewState {
  final CustomerReview reviewModel;

  const ReviewSuccess({
    required this.reviewModel,
  });

  @override
  List<Object> get props => [reviewModel];
}

final class ReviewFailed extends ReviewState {
  final String error;

  const ReviewFailed({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
