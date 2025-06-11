part of 'all_applicants_for_job_cubit.dart';

@immutable
sealed class AllSpecificApplicantsState {}

final class AllSpecificApplicantsInitial extends AllSpecificApplicantsState {}

final class AllSpecificApplicantsLoading extends AllSpecificApplicantsState {}

final class AllSpecificApplicantsSuccess extends AllSpecificApplicantsState {
  final List<ApplicantModel> applicantModelList;

  AllSpecificApplicantsSuccess({required this.applicantModelList});
}

final class NoApplicantsAppliedForJob extends AllSpecificApplicantsState {}

final class AllSpecificApplicantsFailure extends AllSpecificApplicantsState {
  final String errorMessage;

  AllSpecificApplicantsFailure({required this.errorMessage});
}

final class ApplyApplicantLoading extends AllSpecificApplicantsState {}

final class ApplyApplicantAccepted extends AllSpecificApplicantsState {}

final class ApplyApplicantRejected extends AllSpecificApplicantsState {}

final class ApplyApplicantFailure extends AllSpecificApplicantsState {
  final String errorMessage;

  ApplyApplicantFailure({required this.errorMessage});
}

final class ApplicantShortListedSuccess extends AllSpecificApplicantsState {}

final class GetShortListInitial extends AllSpecificApplicantsState {}

final class GetApplicantShortListedSuccess extends AllSpecificApplicantsState {
  final List<ApplicantModel> applicantsList;

  GetApplicantShortListedSuccess({required this.applicantsList});
}

final class ApplicantRemovedShortListed extends AllSpecificApplicantsState {
  final String memberId;

  ApplicantRemovedShortListed({required this.memberId});
}

final class ApplicantShortListedFailure extends AllSpecificApplicantsState {
  final String errorMessage;

  ApplicantShortListedFailure({required this.errorMessage});
}

final class NoApplicantShortListed extends AllSpecificApplicantsState {}
