import 'package:dartz/dartz.dart';
import 'package:shiftswift/home/data/repos/home_repo.dart';

import '../../../core/error/failure.dart';
import '../../../core/model/job_data_model.dart';
import '../../../core/model/rating_model.dart';
import '../../../core/service/api_service.dart';
import '../models/home_model/job_added_model.dart';
import '../models/home_model/job_model.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<List<JobDataModel>> getAllJopPosts() async {
    var response = await apiService.get(
      endPoint: 'Home/GetRandomJobs',
    ); 

    List<dynamic> dataList = response['data']['data'];
    List<JobDataModel> jobs =
        dataList.map((job) => JobDataModel.fromJson(job)).toList();

    return (jobs);
  }

  @override
  Future<RatingModel> getAllCompanyRating({required String companyId}) async {
    var data = await apiService.get(endPoint: 'Company/GetRating/$companyId');
    RatingModel rating = RatingModel.fromJson(data['data']);
    return rating;
  }

  @override
  Future<Either<Failure, List<JobModel>>> getAllJob() async {
    try {
      final jobsResult = await getAllJopPosts();
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
  Future<Either<Failure, JobAddedModel>> addSavedJobs({
    required String jobId,
    required String memberId,
  }) async {
    try {
      var response = await apiService.post(
        endPoint: 'Member/SaveJob?JobId=$jobId&MemberId=$memberId',

      );

      JobAddedModel saveJob = JobAddedModel.fromJson(response);
      return right(saveJob);
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, JobAddedModel>> addAppliedJob({required Map<String, dynamic> body}) async {
    try {
      var response = await apiService.post(
        endPoint: 'Member/AddJobApplication',
        body: body,
      );
      JobAddedModel applyJob = JobAddedModel.fromJson(response);
      return right(applyJob);
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
