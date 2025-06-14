import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shiftswift/company/models/accepted_applicant_model.dart';
import 'package:shiftswift/company/models/applicant_model.dart';
import 'package:shiftswift/constant.dart';

class AllApplicantsForSpecificJobService {
  Future<List<ApplicantModel>> getAllAplicantsForSpecificJob({
    required String jobId,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$companyBaseUrl/GetAllApplicantsForSpecificJob/$jobId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List responseApplicantsList = responseBody['data'];
      List<ApplicantModel> allApplicantsist = [];
      if (responseApplicantsList.isNotEmpty) {
        for (var applicant in responseApplicantsList) {
          ApplicantModel applicantModel = ApplicantModel.fromJson(applicant);
          allApplicantsist.add(applicantModel);
          print('Applicants List length=>${allApplicantsist.length}');
        }
      } else {
        allApplicantsist = [];
        print('Applicants List length=>${allApplicantsist.length}');
      }
      return allApplicantsist;
    } catch (e) {
      return [];
    }
  }

  Future<List<AcceptedApplicantModel>> getAcceptedAppilcants() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$companyBaseUrl/GetMyLastWorkApplicants?CompanyId=$currentId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List responseApplicantsList = responseBody['data'];
      List<AcceptedApplicantModel> allAcepptedApplicantsist = [];
      if (responseApplicantsList.isNotEmpty) {
        for (var applicant in responseApplicantsList) {
          AcceptedApplicantModel applicantModel = AcceptedApplicantModel.fromJson(applicant);
          allAcepptedApplicantsist.add(applicantModel);
          print('Applicants List length=>${allAcepptedApplicantsist.length}');
        }
      } else {
        allAcepptedApplicantsist = [];
        print('Applicants List length=>${allAcepptedApplicantsist.length}');
      }
      return allAcepptedApplicantsist;
    } catch (e) {
      return [];
    }
  }

  Future<List<ApplicantModel>> getShortListedApplicnts({
    required String jobID,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$companyBaseUrl/GetShortlistedMembers/$jobID'),
        headers: {'Authorization': 'Bearer $token'},
      );
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List responseApplicantsList = responseBody['data'];
      List<ApplicantModel> allApplicantsist = [];
      if (responseApplicantsList.isNotEmpty) {
        for (var applicant in responseApplicantsList) {
          ApplicantModel applicantModel = ApplicantModel.fromJson(applicant);
          allApplicantsist.add(applicantModel);
        }
      } else {
        allApplicantsist = [];
      }
      return allApplicantsist;
    } catch (e) {
      return [];
    }
  }

  Future<bool> applicantStatus({
    required String jobId,
    required String memberId,
    required int status,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse(
          '$companyBaseUrl/ApplyApplicant/$jobId?MemberId=$memberId&status=$status',
        ),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('Apply Applicant Respnse=> ${response.body}');
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['data']['status'] == 2) {
        return true; //Accepted
      } else if (responseBody['data']['status'] == 3) {
        return false; //Rejected
      } else if (responseBody['data']['status'] == 4) {
        return true; //ShortListed
      } else {
        return false;
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}
