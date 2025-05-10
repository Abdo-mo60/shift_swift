import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/profile/Models/experience_model.dart';

class ExperienceService {
  Future<void> addExperience({
    required String title,
    required String companyName,
    required String startDate,
    required String endDate,
    required String description,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$memberBaseUrl/AddExperience/$currentId'),
        body: jsonEncode({
          "title": title,
          "companyName": companyName,
          "startDate": startDate,
          "endDate": endDate,
          "description": description,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('Add Experience Response=> $jsonDecode(${response.body})');
      }
      if (response.statusCode == 400) {
        print('Experience Failure Response=> $jsonDecode(${response.body})');

        Map<String, dynamic> responseBody = jsonDecode(response.body);
        throw (responseBody['data']['EndDate'][0]);
      }
    } catch (e) {
      print('Experience Failure request');

      throw Exception(e.toString());
    }
  }

  Future<ExperienceModel> getExperience() async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token'};

      http.Response response = await http.get(
        Uri.parse('$memberBaseUrl/GetExperience/$currentId'),
        headers: headers,
      );
      print('get experience response${response.body}');
      return ExperienceModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteExperience() async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token'};

      http.Response response = await http.delete(
        Uri.parse('$memberBaseUrl/DeleteExperience/$currentId'),
        headers: headers,
      );
      print('Delete experience response${response.body}');
      if (response.statusCode == 404) {
        //no education found
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        throw (responseBody['data'][0]);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
