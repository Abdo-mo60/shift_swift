import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shiftswift/company/models/applicant_details_model.dart';
import 'package:shiftswift/constant.dart';

class ApplicantsDetailsService {
  Future<ApplicantDetailsModel> getApplicantsDetails({
    required String jobId,
    required String applicantID,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
          '$companyBaseUrl/GetSpecificApplicantForSpecificJob?JobId=$jobId&MemberId=$applicantID',
        ),
        headers: {'Authorization': 'Bearer $token'},
      );
      Map<String, dynamic> responseBody = jsonDecode(response.body);
print('Applicant Details Respone=>$responseBody');
      return ApplicantDetailsModel.fromJson(responseBody);
      
    } catch (e) {
      throw (e.toString());
    }
  }
}
