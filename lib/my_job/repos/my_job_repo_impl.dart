import 'package:dartz/dartz.dart';
import 'package:shiftswift/constant.dart';
import '../../core/error/failure.dart';
import '../../core/model/job_data_model.dart';
import '../../core/model/rating_model.dart';
import '../../core/service/api_service.dart';
import '../../home/data/models/home_model/job_model.dart';
import '../model/applied_job_model.dart';
import '../model/last_work_model.dart';
import 'my_job_repo.dart';

class MyJobRepoImpl implements MyJobRepo {
  final ApiService apiService;

  MyJobRepoImpl({required this.apiService});
  @override
  Future<RatingModel> getAllCompanyRating({required String companyId}) async {
    var data = await apiService.get(endPoint: 'Company/GetRating?companyId=$companyId');
    RatingModel rating = RatingModel.fromJson(data['data']);
    return rating;
  }

  @override
  Future<List<JobDataModel>> getAllJobs({required String memberId}) async {
    var response = await apiService.get(
      endPoint: 'Member/GetAllSavedJobs/$memberId',
      token: token,
    ); // Corrected the variable name
    List<dynamic> dataList = response['data'];
    List<JobDataModel> jobs =
        dataList.map((job) => JobDataModel.fromJson(job)).toList();
// print('Token from saved view:=>${Ids.tokenFromIds}');
// print('Token from Global:=>$token');
// print('Member Id from saved view:=>${Ids.memberId}');
// print('Current Id Global:=>$currentId');

    return (jobs);
  }

  @override
  Future<Either<Failure, List<JobModel>>> getAllSavedJob({
    required String memberId,
  }) async {
    try {
      final jobsResult = await getAllJobs(memberId: memberId);
      List<JobModel> mergedJobs = [];
      for (var job in jobsResult) {
        var rating = await getAllCompanyRating(companyId: job.companyId);
        mergedJobs.add(JobModel(jobDataModel: job, ratingModel: rating));
      }
      return right(mergedJobs);
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppliedJobModel>>> getAllAppliedJob({
    required String memberId,
  }) async {
    try {
      var response = await apiService.get(
        endPoint: 'Member/GetAllMyJobApplications/$memberId',
        token: token,
      ); // Corrected the variable name
      List<dynamic> dataList = response['data'];
      List<AppliedJobModel> jobs =
          dataList.map((job) => AppliedJobModel.fromJson(job)).toList();

      return right(jobs);
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LastWorkModel>>> getLastWork() async {
    try {
      var response = await apiService.get(
        endPoint: 'Member/GetLastWork',
        token: token,
      );

      List<dynamic> dataList = response['data'];
      List<LastWorkModel> jobs =
          dataList.map((job) => LastWorkModel.fromJson(job)).toList();
      return right(jobs);
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> addRate({
    required String companyId,
    required String memberId,
    required Map<String, dynamic> body,
  }) async {
    try {
      var response = await apiService.post(
        endPoint: 'Member/AddRating/$companyId?RatedById=$memberId',
        token: token,
        body: body,
      );
      dynamic message = response['message'];
      return right(message);
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
