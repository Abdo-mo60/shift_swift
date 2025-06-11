part of 'company_job_posts_cubit.dart';

@immutable
sealed class CompanyJobPostsState {}

final class CompanyJobPostsInitial extends CompanyJobPostsState {}

final class CreateJobPostsLoading extends CompanyJobPostsState {}

final class CreateJobPostsSuccess extends CompanyJobPostsState {}

final class CreateJobPostsFailure extends CompanyJobPostsState {
  final String errorMessage;

  CreateJobPostsFailure({required this.errorMessage});
}

final class GetCompanyJobPostsLoading extends CompanyJobPostsState {}

final class GetCompanyJobPostsSuccess extends CompanyJobPostsState {
  final List<CompanyJobPostModel> jobPostList;

  GetCompanyJobPostsSuccess({required this.jobPostList});
}

final class GetCompanyJobPostsFailure extends CompanyJobPostsState {
  final String errorMessage;
  GetCompanyJobPostsFailure({required this.errorMessage});
}

final class DeleteCompanyJobPostsLoading extends CompanyJobPostsState {}

final class DeleteCompanyJobPostsSuccess extends CompanyJobPostsState {
  final String jobId;

  DeleteCompanyJobPostsSuccess({required this.jobId});
}

final class DeleteCompanyJobPostsFailure extends CompanyJobPostsState {
  final String errorMessage;
  DeleteCompanyJobPostsFailure({required this.errorMessage});
}
