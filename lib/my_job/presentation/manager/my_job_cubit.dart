import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shiftswift/constant.dart';
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
   Future<void> removeFromSave({required String jobId}) async {
    try {
      emit(RemoveSavedjobcubitLoading());
      await RemoveSavedjobService().removeSavedjob(jobId: jobId);
      emit(RemoveSavedjobcubitSuccess());
    } catch (e) {
      emit(RemoveSavedjobcubitFailure(erorrMessage: e.toString()));
    }
  }
}
class RemoveSavedjobService {
  Future<void> removeSavedjob({required String jobId}) async {
    try {
  http.Response response    =await http.put(
        Uri.parse('$memberBaseUrl/RemoveJobFromSavedJobs?jobId=$jobId'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print('remove from save satus code=>${response.statusCode}');
    } catch (e) {
      throw (e.toString());
    }
  }
}