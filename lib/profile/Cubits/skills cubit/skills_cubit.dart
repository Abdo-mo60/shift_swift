import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/profile/Models/skills_model.dart';
import 'package:shiftswift/profile/Services/skills_service.dart';

part 'skills_state.dart';

class SkillsCubit extends Cubit<SkillsState> {
  SkillsCubit() : super(SkillsInitial());
  SkillsModel? skillsModel;
  Future<void> addSkills({required String skillName}) async {
    try {
      emit(AddSkillsLoading());
      await SkillsService().addSkills(skillName: skillName);
      emit(AddSkillsSuccess());
    } catch (e) {
      emit(AddSkillsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getSkills() async {
    try {
      emit(GetSkillsLoading());
      skillsModel = await SkillsService().getSkills();
      emit(GetSkillsSuccess(skillsModel: skillsModel!));
    } catch (e) {
      emit(GetSkillsFailure(errorMessage: e.toString()));
    }
  }

  Future<void> delteSkills() async {
    try {
      emit(DeleteSkillsLoading());
      await SkillsService().deleteSkills();
      emit(DeleteSkillsSuccess());
    } catch (e) {
      emit(DeleteSkillsFailure(errorMessage: e.toString()));
    }
  }
}
