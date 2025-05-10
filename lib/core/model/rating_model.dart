class RatingModel {
  final String companyId;
  dynamic averageScore;
  List<dynamic>? ratings;

  RatingModel({required this.companyId, this.averageScore, this.ratings});

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
    companyId: json['companyId'],
    averageScore: json['averageScore'] as dynamic,
    ratings: json['ratings'] as List<dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'companyId': companyId,
    'averageScore': averageScore,
    'ratings': ratings,
  };
}
