import 'package:dartz/dartz.dart';
import '../../constant.dart' as Ids;
import '../../core/error/failure.dart';
import '../../core/model/job_data_model.dart';
import '../../core/model/rating_model.dart';
import '../../core/service/api_service.dart';
import '../../home/data/models/home_model/job_model.dart';
import '../model/applied_job_model.dart';
import 'my_job_repo.dart';

class MyJobRepoImpl implements MyJobRepo {
  final ApiService apiService;

  MyJobRepoImpl({required this.apiService});
  @override
  Future<RatingModel> getAllCompanyRating({required String companyId}) async {
    var data = await apiService.get(endPoint: 'Company/GetRating/$companyId');
    RatingModel rating = RatingModel.fromJson(data['data']);
    return rating;
  }

  @override
  Future<List<JobDataModel>> getAllJobs({required String memberId}) async {
    var response = await apiService.get(
      endPoint: 'Member/GetAllSavedJobs/$memberId',
      token:
          Ids.token,
    ); 
    List<dynamic> dataList = response['data'];
    List<JobDataModel> jobs =
        dataList.map((job) => JobDataModel.fromJson(job)).toList();

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
  Future<Either<Failure,List<AppliedJobModel>>> getAllAppliedJob({required String memberId}) async {
    try {
  var response = await apiService.get(
    endPoint: 'Member/GetAllMyJobApplications/$memberId',
    token:
        Ids.token,
  ); // Corrected the variable name
  List<dynamic> dataList = response['data'];
  List<AppliedJobModel> jobs =
      dataList.map((job) => AppliedJobModel.fromJson(job)).toList();
  
  return right(jobs);
} on Exception catch (e) {
  return left(ServerFailure(errorMessage: e.toString()));
}
  }
}
