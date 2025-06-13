import 'package:intl/intl.dart';

class ReviewsModel {
  final String comment;
  final String createdAt;
  final String ratedByUserNAme;
  final String ratedByImageUrl;
  final double score;
  final double avgScore;
  final int numberOfReviews;
  ReviewsModel({
    required this.comment,
    required this.createdAt,
    required this.ratedByUserNAme,
    required this.ratedByImageUrl,
    required this.score,
    required this.avgScore,
    required this.numberOfReviews,
  });

  factory ReviewsModel.fromJson({
    reviewItem,
    double? avgScore,
    required int numberOfReviews,
  }) {
    if (reviewItem == null) {
      return ReviewsModel(
        comment: '',
        createdAt: '',
        ratedByImageUrl: '',
        ratedByUserNAme: '',
        score: 0,
        avgScore: avgScore ?? 0,
        numberOfReviews: numberOfReviews,
      );
    } else {
      String date = reviewItem['createdAt'];

      String formattedDate = '';

      DateTime parsedDate = DateTime.parse(date);

      formattedDate = DateFormat('hh:mm a, dd MMM yyyy').format(parsedDate);

      return ReviewsModel(
        comment: reviewItem['comment'],
        createdAt: formattedDate,
        ratedByImageUrl:
            (reviewItem['ratedByImageUrl'] == null)
                ? ''
                : reviewItem['ratedByImageUrl'],
        ratedByUserNAme: reviewItem['ratedByUserName'],
        score: reviewItem['score'],
        avgScore: avgScore!,
        numberOfReviews: numberOfReviews,
      );
    }
  }
}
