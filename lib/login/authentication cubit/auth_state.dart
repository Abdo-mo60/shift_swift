part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}
final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

// ignore: must_be_immutable
final class FailedToRegisterState extends AuthState {
  String errorMessage;
  FailedToRegisterState({required this.errorMessage});
}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

// ignore: must_be_immutable
class FailedTOLoginState extends AuthState {
  String errorMessage;
  FailedTOLoginState({required this.errorMessage});
}

class LogOutStateSuccessfully extends AuthState {}

class FailedToLogOutState extends AuthState {}