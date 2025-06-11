part of 'add_update_person_info_cubit.dart';

@immutable
sealed class AddUpdatePersonInfoState {}

final class AddUpdatePersonInfoInitial extends AddUpdatePersonInfoState {}

final class AddUpdatePersonInfoLoading extends AddUpdatePersonInfoState {}

final class AddUpdatePersonInfoSuccess extends AddUpdatePersonInfoState {}

final class AddUpdatePersonInfoFailure extends AddUpdatePersonInfoState {
  final String errorMessage;

  AddUpdatePersonInfoFailure({required this.errorMessage});
}

final class GetPersonInfoLoading extends AddUpdatePersonInfoState {}

final class GetPersonInfoFailure extends AddUpdatePersonInfoState {
  final String errorMessage;

  GetPersonInfoFailure({required this.errorMessage});
}

final class GetPersonInfoSuccess extends AddUpdatePersonInfoState {
  final PersonalInfoModel personalInfoModel;

  GetPersonInfoSuccess({required this.personalInfoModel});
}
