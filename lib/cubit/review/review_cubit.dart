import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/review_model.dart';
import '../../services/review_service.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  void createReviews({
    required String id,
    required String name,
    required String review,
  }) async {
    emit(ReviewLoading());
    try {
      final reviewModel = await ReviewService().createReviews(
        id: id,
        name: name,
        review: review,
      );

      emit(ReviewSuccess(reviewModel: reviewModel));
    } catch (e) {
      emit(ReviewFailed(error: e.toString()));
    }
  }
}
