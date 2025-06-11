part of 'reviews_cubit.dart';

@immutable
sealed class ReviewsState {}

final class ReviewsInitial extends ReviewsState {}
final class NoReviews extends ReviewsState {}

final class ReviewsLoading extends ReviewsState {}

final class ReviewsSuccess extends ReviewsState {
  final List<ReviewsModel> reviewsList;

  ReviewsSuccess({required this.reviewsList});
}

final class ReviewsFailure extends ReviewsState {
  final String message;

  ReviewsFailure({required this.message});
}
