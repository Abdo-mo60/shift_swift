import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../core/model/job_data_model.dart';
import '../models/home_model/job_added_model.dart';
import '../models/home_model/job_model.dart';
import '../../../core/model/rating_model.dart';

abstract class HomeRepo {
  Future<List<JobDataModel>> getAllJopPosts();
  Future<RatingModel> getAllCompanyRating({required String companyId});
  Future<Either<Failure, List<JobModel>>> getAllJob();
  Future<Either<Failure, JobAddedModel>> addSavedJobs({required String jobId,required String memberId});
  Future<Either<Failure, JobAddedModel>> addAppliedJob({required Map<String, dynamic> body});
}
