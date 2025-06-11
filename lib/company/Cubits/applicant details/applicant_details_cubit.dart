import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/company/models/applicant_details_model.dart';
import 'package:shiftswift/company/services/applicants_details_service.dart';

part 'applicant_details_state.dart';

class ApplicantDetailsCubit extends Cubit<ApplicantDetailsState> {
  ApplicantDetailsCubit() : super(ApplicantDetailsInitial());
 ApplicantDetailsModel? applicantDetailsModel;
  Future<void> getApplicantsDetails({
    required String jobId,
    required String applicantID,
  }) async {
    try {
      emit(ApplicantDetailsLoading());
     applicantDetailsModel= await ApplicantsDetailsService().getApplicantsDetails(
        jobId: jobId,
        applicantID: applicantID,
      );
      print('Applicant details model=>$applicantDetailsModel');
      emit(ApplicantDetailsSuccess(applicantDetailsModel: applicantDetailsModel!));
    } catch (e) {

      emit(ApplicantDetailsFailure(errorMessage: e.toString()));
    }
  }
}
