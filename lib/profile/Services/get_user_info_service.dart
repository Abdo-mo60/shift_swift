import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/profile/Models/user_info_model.dart';

class GetUserInfoService {
  Future<UserInfoModel> getUserInfo() async {
    try {
  //   print('tokenInService=>$token');
      Map<String, String> headers = {'Authorization': 'Bearer $token'};

      http.Response response = await http.get(
        Uri.parse('$accountBaseUrl/GetCurrentUserInformation'),
        headers: headers,
      );
      // print('Response Status Code: ${response.statusCode}');
      // print('respone=>:${response.body}');

      return UserInfoModel.fromJson(jsonDecode(response.body));
    } catch (e) {
    //  print('oops there wan an error try later');
      throw Exception(e.toString());
    }
  }
}
