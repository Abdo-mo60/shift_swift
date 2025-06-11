import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/profile/Models/company_info_model.dart';

class AddUpdateCompanyDataService {
  Future<void> addUpdateCompanyData({
    required String firstName,
    required String lastName,
    required String country,
    required String city,
    required String area,
    required String phoneNumber,
    required String overView,
    required String field,
    required String dateOfEstablish,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$companyBaseUrl/AddOrUpdateCompanyProfileData'),
        headers: {
          'Authorization': 'Bearer $token',
          'content-type': 'application/json',
        },
        body: jsonEncode({
          "companyId": currentId,
          "firstName": firstName,
          "lastName": lastName,
          "overview": overView,
          "field": field,
          "dateOfEstablish": dateOfEstablish,
          "country": country,
          "city": city,
          "area": area,
          "phoneNumber": phoneNumber,
        }),
      );
      if (response.statusCode == 200) {
        print('Add Company data Respone=> $jsonDecode(${response.body})');
      }
    } catch (e) {
      print('failed to send data from service');
      throw (e.toString());
    }
  }

  Future<CompanyInfoModel> getCompanyInfo() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$accountBaseUrl/GetCompanyInfoById/$currentId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Response status: ${response.statusCode}');

      print('get company response${response.body}');
      var jsonData = jsonDecode(response.body);
      print('Parsed JSON data: $jsonData');

      return CompanyInfoModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw (e.toString());
    }
  }
}
