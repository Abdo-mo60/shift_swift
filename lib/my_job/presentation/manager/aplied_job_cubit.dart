import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repos/my_job_repo.dart';
import 'aplied_job_state.dart';

class ApliedJobCubit extends Cubit<AppliedJobState> {
  final MyJobRepo myJobRepo;
  ApliedJobCubit(this.myJobRepo) : super(AppliedJobInitial());

  Future<void> getAllAppliedJob({required String memberId}) async {
    emit(AppliedJobLoading());
    var result = await myJobRepo.getAllAppliedJob(memberId: memberId);
    
    result.fold(
      (fail) {
        emit(AppliedJobFailure(errorMessage: fail.errorMessage));
      },
      (jobs) {
        emit(AppliedJobSuccess(jobs: jobs));
      },
    );
  }
}
