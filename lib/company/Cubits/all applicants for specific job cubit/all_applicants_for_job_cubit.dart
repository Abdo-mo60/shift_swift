import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/company/models/applicant_model.dart';
import 'package:shiftswift/company/services/all_applicants_specific_job.dart';

part 'all_applicants_for_job_state.dart';

class AllSpecificApplicantsCubit extends Cubit<AllSpecificApplicantsState> {
  AllSpecificApplicantsCubit() : super(AllSpecificApplicantsInitial());
  List<ApplicantModel>? applicantsList;
  Future<void> getAllApplicantsForSpecificJob({required String jobId}) async {
    if (jobId != '') {
      try {
        emit(AllSpecificApplicantsLoading());
        applicantsList = await AllApplicantsForSpecificJobService()
            .getAllAplicantsForSpecificJob(jobId: jobId);
        if (applicantsList!.isNotEmpty) {
          print('Applicants List length=>${applicantsList!.length}');

          emit(
            AllSpecificApplicantsSuccess(applicantModelList: applicantsList!),
          );
        } else {
          print('Applicants List length=>${applicantsList!.length}');

          emit(NoApplicantsAppliedForJob());
        }
      } catch (e) {
        emit(
          AllSpecificApplicantsFailure(
            errorMessage: 'Could not find a list of applicants',
          ),
        );
      }
    } else {
      emit(AllSpecificApplicantsInitial());
    }
  }

  Future<void> getShortListedApplicnts({required String jobID}) async {
    if (jobID.isNotEmpty) {
      try {
        applicantsList = await AllApplicantsForSpecificJobService()
            .getShortListedApplicnts(jobID: jobID);
        if (applicantsList!.isNotEmpty) {
          emit(GetApplicantShortListedSuccess(applicantsList: applicantsList!));
        } else {
          emit(NoApplicantShortListed());
        }
      } catch (e) {
        emit(ApplicantShortListedFailure(errorMessage: e.toString()));
      }
    } else {
      emit(GetShortListInitial());
    }
  }

  Future<void> applyApplicant({
    required String jobId,
    required String memberId,
    required int status,
  }) async {
    try {
      emit(ApplyApplicantLoading());
      bool applicantStatus = await AllApplicantsForSpecificJobService()
          .applicantStatus(jobId: jobId, memberId: memberId, status: status);

      if (applicantStatus == true) {
        emit(ApplyApplicantAccepted());
      } else if (applicantStatus == false) {
        emit(ApplyApplicantRejected());
      }
    } catch (e) {
      emit(ApplyApplicantFailure(errorMessage: e.toString()));
    }
  }

  Future<void> shortListApplicant({
    required String jobId,
    required String memberId,
    required int status,
  }) async {
    try {
      bool applicantStatus = await AllApplicantsForSpecificJobService()
          .applicantStatus(jobId: jobId, memberId: memberId, status: status);

      if (applicantStatus == true) {
        emit(ApplicantShortListedSuccess());
      } else if (applicantStatus == false) {
        emit(ApplicantRemovedShortListed(memberId: memberId));
      }
    } catch (e) {
      emit(ApplicantShortListedFailure(errorMessage: e.toString()));
    }
  }
}
