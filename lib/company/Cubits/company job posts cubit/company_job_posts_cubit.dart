import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/services/company_posts_service.dart';

part 'company_job_posts_state.dart';

class CompanyJobPostsCubit extends Cubit<CompanyJobPostsState> {
  CompanyJobPostsCubit() : super(CompanyJobPostsInitial());
  List<CompanyJobPostModel>? jobPostsList;
  Future<void> getAllJobPostsForComapny() async {
    try {
      emit(GetCompanyJobPostsLoading());
      jobPostsList = await CompanyPostsService().getAllJobPostsForComapny();
      //   emit(GetCompanyJobPostsFailure(errorMessage: 'no jobs found'));

      emit(GetCompanyJobPostsSuccess(jobPostList: jobPostsList!));
      print('cubit success');
    } catch (e) {
      emit(GetCompanyJobPostsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> deleteJobPostForCompany({required String jobId}) async {
    try {
      emit(DeleteCompanyJobPostsLoading());
      await CompanyPostsService().deleteJobPostForCompany(jobId: jobId);
      emit(DeleteCompanyJobPostsSuccess(jobId: jobId));
    } catch (e) {
      emit(DeleteCompanyJobPostsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> createJobPostForCompany({
    required String title,
    required String description,
    required String location,
    required String requirements,
    // required String keywords,
    required int salary,
    required int salaryType,
    required int workMode,
    required int jobType,
 
  }) async {
    emit(CreateJobPostsLoading());
    try {
      await CompanyPostsService().createJobPostForCompany(
        title: title,
        description: description,
        location: location,
        requirements: requirements,
        // keywords: keywords,
        salary: salary,
        salaryType: salaryType,
        workMode: workMode,
        jobType: jobType,
      );
      emit(CreateJobPostsSuccess());
    } catch (e) {
      emit(CreateJobPostsFailure(errorMessage: e.toString()));
    }
  }
}
