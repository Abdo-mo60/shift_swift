import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/profile/Models/company_info_model.dart';
import 'package:shiftswift/profile/Services/add_update_company_data.dart';

part 'add_update_company_data_state.dart';

class AddUpdateCompanyDataCubit extends Cubit<AddUpdateCompanyDataState> {
  AddUpdateCompanyDataCubit() : super(AddUpdateCompanyDataInitial());
  CompanyInfoModel? companyInfoModel;
  Future<void> addUpdateCompanyData({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String country,
    required String city,
    required String area,
    required String overView,
    required String field,
    required String dateOfEstablish,
  }) async {
    try {
      emit(AddUpdateCompanyDataLoading());
      await AddUpdateCompanyDataService().addUpdateCompanyData(
        firstName: firstName,
        lastName: lastName,
        country: country,
        city: city,
        area: area,
        phoneNumber: phoneNumber,
        overView: overView,
        field: field,
        dateOfEstablish: dateOfEstablish,
      );

      emit(AddUpdateCompanyDataSuccess());
      await getCompanyInfo();
    } catch (e) {
      emit(AddUpdateCompanyDataFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getCompanyInfo() async {
    try {
      emit(GetCompanyDataLoading());
      companyInfoModel = await AddUpdateCompanyDataService().getCompanyInfo();
      emit(GetCompanyDataSuccess(companyInfoModel: companyInfoModel!));
    } catch (e) {
      emit(GetCompanyDataFailure(errorMessage: e.toString()));
    }
  }
}
