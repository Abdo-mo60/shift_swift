part of 'lastwork_cubit.dart';


abstract class LastworkState {}

class LastworkInitial extends LastworkState {}
class LastworkLoading extends LastworkState {}
class LastworkSuccessful extends LastworkState {
  final List<LastWorkModel> jobs;
  LastworkSuccessful({required this.jobs});
}
class LastworkFailure extends LastworkState {
  final String errorMessage;
  LastworkFailure({required this.errorMessage});  
}
class AddRatingLoading extends LastworkState {}
class AddRatingSuccessful extends LastworkState {
  final String message;
  AddRatingSuccessful({required this.message});
}
class AddRatingFailure extends LastworkState {
  final String errorMessage;
  AddRatingFailure({required this.errorMessage});
}

