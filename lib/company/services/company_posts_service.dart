import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/profile/Models/reviews_model.dart';
import 'package:shiftswift/profile/Services/get_reviews_service.dart';

class CompanyPostsService {
  Future<List<CompanyJobPostModel>> getAllJobPostsForComapny() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$companyBaseUrl/GetAllJobPostsForCompany/$currentId'),
        headers: {'Authorization': ' Bearer $token'},
      );

      Map<String, dynamic> responseBody = jsonDecode(response.body);
      print('Get Job Response=> ${response.body}');
      List responseJobsList = responseBody['data'];
      if (responseJobsList[0] is String) {
        CompanyJobPostModel jobPostModel = CompanyJobPostModel.fromJson(
          job: responseJobsList,
        );
        print('no job post model');
        return [jobPostModel];
      } else {
        List<ReviewsModel> reviewsmodel = await GetReviewsService().getReviews(
          companyId: currentId!,
        );

        List<CompanyJobPostModel> allJobPostsList = [];

        for (var job in responseJobsList) {
          CompanyJobPostModel jobModel = CompanyJobPostModel.fromJson(
            job: job,
            avgRating: reviewsmodel[0].avgScore,
            numOfreviews: reviewsmodel[0].numberOfReviews,
          );
          allJobPostsList.add(jobModel);
        }
        allJobPostsList.sort((a, b) => b.postedOn!.compareTo(a.postedOn!));
        print('jobs list$allJobPostsList');
        return allJobPostsList;
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteJobPostForCompany({required String jobId}) async {
    try {
      await http.delete(
        Uri.parse('$companyBaseUrl/DeleteJobPost/$jobId'),
        headers: {'Authorization': ' Bearer $token'},
      );
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> createJobPostForCompany({
    required String title,
    required String description,
    required String location,
    required String requirements,
    // required String keywords,
    required int salary,
    required int salaryType,
    required int workMode,
    required int jobType,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$companyBaseUrl/CreateJobPost'),
        body: jsonEncode({
          "title": title,
          "description": description,
          "location": location,
          "jobType": jobType,
          "workMode": workMode,
          "salary": salary,
          "salaryType": salaryType,
          "requirements": requirements,
          "keywords": 'keywords',
        }),
        headers: {
          'Authorization': ' Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print('Create post Respones=> ${response.body}');
    } catch (e) {
      throw (e.toString());
    }
  }
}
