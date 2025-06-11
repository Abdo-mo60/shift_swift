import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/profile/Models/personal_info_model.dart';
import 'package:shiftswift/profile/Services/add_update_personal_data.dart';

part 'add_update_person_info_state.dart';

class AddUpdatePersonInfoCubit extends Cubit<AddUpdatePersonInfoState> {
  AddUpdatePersonInfoCubit() : super(AddUpdatePersonInfoInitial());
  PersonalInfoModel? personalInfoModel;
  Future<void> addUpdatePersonData({
    required String firstName,
    required String lastName,
    required String country,
    required String city,
    required String area,
    required int gender,
    required String level,
    required String faculty,
    required String universityName,
    required String phoneNumber,
    required String alternativePhoneNumber,
    required String dateOfBirth,
  }) async {
    try {
      emit(AddUpdatePersonInfoLoading());
      await AddUpdatePersonalDataService().addUpdatePersonData(
        firstName: firstName,
        lastName: lastName,
        country: country,
        gender: gender,
        level: level,
        faculty: faculty,
        universityName: universityName,
        phoneNumber: phoneNumber,
        alternativePhoneNumber: alternativePhoneNumber,
        city: city,
        area: area,
        dateOfBirth: dateOfBirth,
      );

      emit(AddUpdatePersonInfoSuccess());
      await getPersonalInfo();
    } catch (e) {
      emit(AddUpdatePersonInfoFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getPersonalInfo() async {
    try {
      emit(GetPersonInfoLoading());
      personalInfoModel = await AddUpdatePersonalDataService().getPersonInfo();
      emit(GetPersonInfoSuccess(personalInfoModel: personalInfoModel!));
    } catch (e) {
      emit(GetPersonInfoFailure(errorMessage: e.toString()));
    }
  }
}
