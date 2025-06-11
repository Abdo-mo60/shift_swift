import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/profile/Models/reviews_model.dart';

class GetReviewsService {
  Future<List<ReviewsModel>> getReviews({required String companyId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$companyBaseUrl/GetRating?companyId=$companyId'),
        headers: {'Authorization': ' Bearer $token'},
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      print('Get Reviews Response=> ${response.body}');
      List<dynamic> responseReviews = responseBody['data']['ratings'];
      final avgScore = responseBody['data']['averageScore'];
      final numOfReviews = responseReviews.length;

      print('Length of response reviews=>${responseReviews.length}');
      if (responseReviews.isEmpty) {
        List<ReviewsModel> allReviews = [];
        ReviewsModel reviewModel = ReviewsModel.fromJson(
          reviewItem: null,
          avgScore: 0,
          numberOfReviews: 0,
        );

        allReviews.add(reviewModel);

        print('no Reviews model');
        return allReviews;
      } else {
        List<ReviewsModel> allReviews = [];
        for (var review in responseReviews) {
          ReviewsModel reviewModel = ReviewsModel.fromJson(
            reviewItem: review,
            avgScore: avgScore,
            numberOfReviews: numOfReviews,
          );
          print("rated by user name=>: ${reviewModel.ratedByUserNAme}");

          allReviews.add(reviewModel);
        }
        print('allreviews $allReviews');
        return allReviews;
      }
    } catch (e) {
      return [];
    }
  }
}
