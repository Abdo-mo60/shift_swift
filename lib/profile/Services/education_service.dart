import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/profile/Models/education_model.dart';

class EducationService {
  Future<void> addEducation({
    required String universityName,
    required String level,
    required String faculty,
  }) async {
    Map <String,String> headers={
          'Authorization': 'Bearer $token',
          'content-type': 'application/json',
        };
    try {
      http.Response response = await http.post(
        Uri.parse('$memberBaseUrl/AddEducation/$currentId'),
        body: jsonEncode({
          "level": level,
          "faculty": faculty,
          "universityName": universityName,
        }),
        headers:headers ,
      );
      if (response.statusCode == 200) {
        print('Add Education Respone=> $jsonDecode(${response.body})');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<EducationModel> getEducation() async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token'};

      http.Response response = await http.get(
        Uri.parse('$memberBaseUrl/GetEducation/$currentId'),
        headers: headers,
      );
      print('get eductaion response${response.body}');
      return EducationModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<void>deleteEducation()async{
    try {
          Map<String, String> headers = {'Authorization': 'Bearer $token'};

      http.Response response = await http.delete(
        Uri.parse('$memberBaseUrl/DeleteEducation/$currentId'),
        headers: headers,
      );
      print('Delete Education response${response.body}');
      if (response.statusCode == 404) {
        //No education found
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        throw (responseBody['data'][0]);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
