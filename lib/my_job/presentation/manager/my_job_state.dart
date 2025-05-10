import '../../../home/data/models/home_model/job_model.dart';

abstract class MyJobState {}

class  MyJobInitial extends MyJobState {}

class  MyJoboading extends MyJobState {}

class  MyJobFailure extends MyJobState {
  final String errorMessage;

   MyJobFailure({required this.errorMessage});
}

class  MyJobSuccess extends MyJobState {
  final List<JobModel> jobs;

   MyJobSuccess({required this.jobs});
}
