import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/last_work_model.dart';
import '../../repos/my_job_repo.dart';
part 'lastwork_state.dart';

class LastworkCubit extends Cubit<LastworkState> {
  LastworkCubit(this.myJobRepo) : super(LastworkInitial());
  final MyJobRepo myJobRepo;
  Future<void> getAllLastWork() async {
    emit(LastworkLoading());
    var result = await myJobRepo.getLastWork();

    result.fold(
      (fail) {
        emit(LastworkFailure(errorMessage: fail.errorMessage));
      },
      (jobs) {
        emit(LastworkSuccessful(jobs: jobs));
      },
    );
  }

  void addRating({
    required Map<String, dynamic> body,
    required String memberId,
    required String companyId,
  }) async {
    emit(AddRatingLoading());
    var result = await myJobRepo.addRate(
      companyId: companyId,
      memberId: memberId,
      body: body,
    );
    
    result.fold(
      (fail) {
        emit(AddRatingFailure(errorMessage: fail.errorMessage));
      },
      (message) {
        emit(AddRatingSuccessful(message: message));
      },
    );
    getAllLastWork();
  }
}
