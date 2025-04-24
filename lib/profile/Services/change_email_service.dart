import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shiftswift/constant.dart';

class ChangeEmailService {
  Future<void> changeEmail({required String newEmail}) async {
    try {
      String url =
          (accType == 'Member')
              ? '$memberBaseUrl/ChangeMemberEmail'
              : '$companyBaseUrl/ChangeCompanyEmail';
      http.Response response = await http.post(
        Uri.parse('$url/$currentId?Email=$newEmail'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        print('responebody=>${response.body}');
      } else {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        final String? specificMessage = responseBody['data']?['Email']?[0];
        final String errorMessage =
            specificMessage ?? 'Email Field Is Required!';

        throw (errorMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
