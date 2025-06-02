class Rating {
  final num score;
  final String comment;
  final String createdAt;
  final String ratedByUserName;

  Rating({
    required this.score,
    required this.comment,
    required this.createdAt,
    required this.ratedByUserName,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        score: json['score'],
        comment: json['comment'],
        createdAt: json['createdAt'],
        ratedByUserName: json['ratedByUserName'],
      );

  Map<String, dynamic> toJson() => {
        'score': score,
        'comment': comment,
        'createdAt': createdAt,
        'ratedByUserName': ratedByUserName,
      };
}

class RatingModel {
  final String companyId;
  dynamic averageScore;
  List<Rating>? ratings;

  RatingModel({required this.companyId, this.averageScore, this.ratings});

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        companyId: json['companyId'],
        averageScore: json['averageScore'] as dynamic,
        ratings: (json['ratings'] as List<dynamic>?)
            ?.map((item) => Rating.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'companyId': companyId,
        'averageScore': averageScore,
        'ratings': ratings?.map((rating) => rating.toJson()).toList(),
      };
}