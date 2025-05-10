part of 'education_cubit.dart';

@immutable
sealed class EducationState {}

final class AddEducationInitial extends EducationState {}
final class AddEducationLoading extends EducationState {}

final class AddEducationSuccess extends EducationState {}

final class AddEducationFailure extends EducationState {
  String errorMessage;
  AddEducationFailure({required this.errorMessage});
}

final class GetEducationLoading extends EducationState {}

final class GetEducationSuccess extends EducationState {
final EducationModel educationModel;

  GetEducationSuccess({required this.educationModel});

}

final class GetEducationFailure extends EducationState {
  String errorMessage;
  GetEducationFailure({required this.errorMessage});
}
final class DeleteEducationLoading extends EducationState {}

final class DeleteEducationSuccess extends EducationState {}
 
final class DeleteEducationFailed extends EducationState {
  String errorMessage;
  DeleteEducationFailed({required this.errorMessage});
}
