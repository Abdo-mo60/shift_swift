import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/profile/Models/experience_model.dart';
import 'package:shiftswift/profile/Services/experience_service.dart';

part 'experience_state.dart';

class ExperienceCubit extends Cubit<ExperienceState> {
  ExperienceCubit() : super(AddExperienceInitial());
  ExperienceModel ?experienceModel;
  Future<void> addExperience({
    required String title,
    required String companyName,
    required String startDate,
    required String endDate,
    required String description,
  }) async {
    try {
      emit(AddExperienceLoading());
      await ExperienceService().addExperience(
        title: title,
        companyName: companyName,
        startDate: startDate,
        endDate: endDate,
        description: description,
      );
      emit(AddExperienceSuccess());
      
    } catch (e) {
      emit(
        AddExperienceFailure(
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
      print(e.toString());
    }
  }

  Future<void> getExperience() async {
    try {
      emit(GetExperienceLoading());
      experienceModel = await ExperienceService().getExperience();
      emit(GetExperienceSuccess(experienceModel: experienceModel!));
    } catch (e) {
      emit(GetExperienceFailure(errorMessage: e.toString()));
    }
  }
  Future<void> deleteExperience()async{
    try {
      emit(DeleteExperienceLoading());
      await ExperienceService().deleteExperience();
      emit(DeleteExperienceSuccess());
    } catch (e) {
      emit(DeleteExperienceFailed(errorMessage: e.toString()));
    }
  }
}
