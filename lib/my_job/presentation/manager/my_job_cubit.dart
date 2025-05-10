import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repos/my_job_repo.dart';
import 'my_job_state.dart';

class MyJobCubit extends Cubit<MyJobState> {
  MyJobCubit(this.myJobRepo) : super(MyJobInitial());
  final MyJobRepo myJobRepo;
  Future<void> getAllJob({
    required String memberId,

  }) async {
    emit(MyJoboading());
    var result = await myJobRepo.getAllSavedJob(
      memberId: memberId,
    );

    result.fold(
      (fail) {
        emit(MyJobFailure(errorMessage: fail.errorMessage));
      },
      (jobs) {
        emit(MyJobSuccess(jobs: jobs));
      },
    );
  }
}
