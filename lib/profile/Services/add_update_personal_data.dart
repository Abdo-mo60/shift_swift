import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/profile/Models/personal_info_model.dart';

class AddUpdatePersonalDataService {
  Future<void> addUpdatePersonData({
    required String firstName,
    required String lastName,
    required String country,
    required String city,
    required String area,
    required int gender,
    required String level,
    required String faculty,
    required String universityName,
    required String phoneNumber,
    required String alternativePhoneNumber,
    required String dateOfBirth,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'content-type': 'application/json',
    };
    try {
      // http.Response responseEducationData = await http.post(
      //   Uri.parse('$memberBaseUrl/AddEducation/$currentId'),
      //   body: jsonEncode({
      //     "level": level,
      //     "faculty": faculty,
      //     "universityName": universityName,
      //   }),
      //   headers: headers,
      // ); 
      http.Response responsePersonalData = await http.post(
        Uri.parse('$memberBaseUrl/AddOrUpdateMamberProfileData'),
        headers: headers,
        body: jsonEncode({
          "memberId": currentId,
          "firstName": firstName,
          "lastName": lastName,
          "phoneNumber": phoneNumber,
          "alternativeNumber": alternativePhoneNumber,
          "genderId": gender,
          "location": country,
          "city": city,
          "area": area,
          "dateOfBirth":dateOfBirth,
        }),
      );
      if (responsePersonalData.statusCode == 200) {
        print(
          'Add Member data Respone=> $jsonDecode(${responsePersonalData.body})',
        );
      }
      // if (responseEducationData.statusCode == 200) {
      //   print(
      //     'Add Member data Respone=> $jsonDecode(${responseEducationData.body})',
      //   );
      // }
    } catch (e) {
      print('failed to send data from service');
      throw (e.toString());
    }
  }

  Future<PersonalInfoModel> getPersonInfo() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$accountBaseUrl/GetMemberInfoById/$currentId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Response status: ${response.statusCode}');

      print('get company response${response.body}');
      var jsonData = jsonDecode(response.body);
      print('Parsed JSON data: $jsonData');
      return PersonalInfoModel.fromJson(jsonData);
    } catch (e) {
      throw (e.toString());
    }
  }
}
