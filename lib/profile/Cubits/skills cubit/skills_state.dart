part of 'skills_cubit.dart';

@immutable
sealed class SkillsState {}

final class SkillsInitial extends SkillsState {}

final class AddSkillsLoading extends SkillsState {}

final class AddSkillsSuccess extends SkillsState {}

final class AddSkillsFailure extends SkillsState {
  final String errorMessage;

  AddSkillsFailure({required this.errorMessage});
}

final class GetSkillsLoading extends SkillsState {}

final class GetSkillsSuccess extends SkillsState {
  final SkillsModel skillsModel;

  GetSkillsSuccess({required this.skillsModel});
}

final class GetSkillsFailure extends SkillsState {
  final String errorMessage;

  GetSkillsFailure({required this.errorMessage});
}

final class DeleteSkillsLoading extends SkillsState {}

final class DeleteSkillsSuccess extends SkillsState {}

final class DeleteSkillsFailure extends SkillsState {
  final String errorMessage;

  DeleteSkillsFailure({required this.errorMessage});
}
