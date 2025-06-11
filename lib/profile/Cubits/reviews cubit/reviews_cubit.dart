import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/profile/Models/reviews_model.dart';
import 'package:shiftswift/profile/Services/get_reviews_service.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(ReviewsInitial());
  List<ReviewsModel>? reviewsList;
  Future<void> getReviews({required String companyId}) async {
    try {
      emit(ReviewsLoading());
      reviewsList = await GetReviewsService().getReviews(companyId: companyId);
      if (reviewsList![0].numberOfReviews!=0) {
        emit(ReviewsSuccess(reviewsList: reviewsList!));
      } else {
        // If there are no reviews, handle it here
        emit(NoReviews()); // You could emit an empty list if no reviews found
      }
      // print('Reviews cubit success');
    } catch (e) {
      emit(ReviewsFailure(message: e.toString()));
    }
  }
}
