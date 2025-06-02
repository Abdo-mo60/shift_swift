part of 'change_email_cubit.dart';

@immutable
sealed class ChangeEmailState {}

final class ChangeEmailInitial extends ChangeEmailState {}
final class ChangeEmailLoading extends ChangeEmailState {}

final class ChangeEmailSuccess extends ChangeEmailState {}

final class ChangeEmailFailure extends ChangeEmailState {

  String errorMessage;
  ChangeEmailFailure({required this.errorMessage});
}
