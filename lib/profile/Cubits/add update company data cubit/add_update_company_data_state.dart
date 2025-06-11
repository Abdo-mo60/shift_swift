part of 'add_update_company_data_cubit.dart';

@immutable
sealed class AddUpdateCompanyDataState {}

final class AddUpdateCompanyDataInitial extends AddUpdateCompanyDataState {}

final class AddUpdateCompanyDataLoading extends AddUpdateCompanyDataState {}

final class AddUpdateCompanyDataSuccess extends AddUpdateCompanyDataState {}

final class AddUpdateCompanyDataFailure extends AddUpdateCompanyDataState {
  final String errorMessage;

  AddUpdateCompanyDataFailure({required this.errorMessage});
}
final class GetCompanyDataLoading extends AddUpdateCompanyDataState {}


final class GetCompanyDataSuccess extends AddUpdateCompanyDataState {
final CompanyInfoModel companyInfoModel;

  GetCompanyDataSuccess({required this.companyInfoModel});
}

final class GetCompanyDataFailure extends AddUpdateCompanyDataState {
  final String errorMessage;

 GetCompanyDataFailure({required this.errorMessage});
}