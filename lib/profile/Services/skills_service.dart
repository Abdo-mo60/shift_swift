import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/profile/Models/skills_model.dart';

class SkillsService {
  Future<void> addSkills({required String skillName}) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'content-type': 'application/json',
      };
      http.Response response = await http.post(
        Uri.parse('$memberBaseUrl/AddSkill/$currentId'),
        body: jsonEncode({"name": skillName}),
        headers: headers,
      );
      if (response.statusCode == 200) {
        print("add skills Response=> ${response.body}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<SkillsModel> getSkills() async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      http.Response response = await http.get(
        Uri.parse('$memberBaseUrl/GetSkills/$currentId'),
        headers: headers,
      );
      print('get skills response=> ${response.body}');

      return SkillsModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteSkills() async {
    try {
      Map<String, String> headers = {'Authorization': 'Bearer $token'};
      http.Response response = await http.delete(
        Uri.parse('$memberBaseUrl/DeleteSkill/$currentId'),
        headers: headers,
      );
      print('Delete skills response=> ${response.body}');
      if (response.statusCode == 404) {
        //no Skills found
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        throw (responseBody['data'][0]);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
