part of 'applicant_details_cubit.dart';

@immutable
sealed class ApplicantDetailsState {}

final class ApplicantDetailsInitial extends ApplicantDetailsState {}

final class ApplicantDetailsLoading extends ApplicantDetailsState {}

final class ApplicantDetailsSuccess extends ApplicantDetailsState {
 final ApplicantDetailsModel applicantDetailsModel;

  ApplicantDetailsSuccess({required this.applicantDetailsModel});

}

final class ApplicantDetailsFailure extends ApplicantDetailsState {
  final String errorMessage;

  ApplicantDetailsFailure({required this.errorMessage});
}
