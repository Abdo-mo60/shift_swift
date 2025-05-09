import '../../model/applied_job_model.dart';


abstract class AppliedJobState {}

class AppliedJobInitial extends AppliedJobState {}

class AppliedJobLoading extends AppliedJobState {}
class AppliedJobSuccess extends AppliedJobState {
  final List<AppliedJobModel> jobs;
  AppliedJobSuccess({required this.jobs});
}

class AppliedJobFailure extends AppliedJobState {
  final String errorMessage;
  AppliedJobFailure({required this.errorMessage});
}