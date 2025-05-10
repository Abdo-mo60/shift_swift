part of 'home_view_cubit.dart';

@immutable
abstract class HomeViewState {}

class HomeViewInitial extends HomeViewState {}

class HomeViewLoading extends HomeViewState {}

class HomeViewFailure extends HomeViewState {
  final String errorMessage;

  HomeViewFailure({required this.errorMessage});
}

class HomeViewSuccess extends HomeViewState {
  final List<JobModel> jobs;

  HomeViewSuccess({required this.jobs});
}
