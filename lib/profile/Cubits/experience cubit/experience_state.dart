part of 'experience_cubit.dart';

@immutable
sealed class ExperienceState {}

final class AddExperienceInitial extends ExperienceState {}

final class AddExperienceLoading extends ExperienceState {}

final class AddExperienceSuccess extends ExperienceState {}

final class AddExperienceFailure extends ExperienceState {
  String errorMessage;
  AddExperienceFailure({required this.errorMessage});
}
final class GetExperienceLoading extends ExperienceState {}

final class GetExperienceSuccess extends ExperienceState {
final ExperienceModel experienceModel;

  GetExperienceSuccess({required this.experienceModel});

}

final class GetExperienceFailure extends ExperienceState {
  String errorMessage;
  GetExperienceFailure({required this.errorMessage});
}
final class DeleteExperienceLoading extends ExperienceState {}

final class DeleteExperienceSuccess extends ExperienceState {}
 
final class DeleteExperienceFailed extends ExperienceState {
  String errorMessage;
  DeleteExperienceFailed({required this.errorMessage});
}
