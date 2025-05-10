import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../core/model/job_data_model.dart';
import '../../core/model/rating_model.dart';
import '../../home/data/models/home_model/job_model.dart';
import '../model/applied_job_model.dart';

abstract class MyJobRepo {
  Future<RatingModel> getAllCompanyRating({required String companyId});
  Future<List<JobDataModel>> getAllJobs({required String memberId});
  Future<Either<Failure, List<JobModel>>> getAllSavedJob({required String memberId});
 Future<Either<Failure, List<AppliedJobModel>>> getAllAppliedJob({required String memberId}); 
}