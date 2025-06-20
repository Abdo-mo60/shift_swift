import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/profile/Models/education_model.dart';
import 'package:shiftswift/profile/Services/education_service.dart';

part 'education_state.dart';

class EducationCubit extends Cubit<EducationState> {
  EducationCubit() : super(AddEducationInitial());
  EducationModel? educationModel;
  Future<void> addEducation({
    required String universityName,
    required String level,
    required String faculty,
  }) async {
    try {
      emit(AddEducationLoading());
      await EducationService().addEducation(
        universityName: universityName,
        level: level,
        faculty: faculty,
      );
      emit(AddEducationSuccess());
    } catch (e) {
      emit(AddEducationFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getEducation() async {
    try {
      emit(GetEducationLoading());
      educationModel = await EducationService().getEducation();
      emit(GetEducationSuccess(educationModel: educationModel!));
    } catch (e) {
      emit(GetEducationFailure(errorMessage: e.toString()));
    }
  }
  Future<void> deleteEducation()async{
    try {
      emit(DeleteEducationLoading());
      await EducationService().deleteEducation();
      emit(DeleteEducationSuccess());
    } catch (e) {
      emit(DeleteEducationFailed(errorMessage: e.toString()));
    }
  }
}
