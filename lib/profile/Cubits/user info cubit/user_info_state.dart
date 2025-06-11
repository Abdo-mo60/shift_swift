part of 'user_info_cubit.dart';

@immutable
sealed class UserInfoState {}

final class UserInfoInitial extends UserInfoState {}

final class UserInfoLoading extends UserInfoState {}

final class UserInfoSuccess extends UserInfoState {
  final UserInfoModel usermodel;

  UserInfoSuccess({required this.usermodel});

}

final class UserInfoFailure extends UserInfoState {
  final String errorMessage;

  UserInfoFailure({required this.errorMessage});
}
