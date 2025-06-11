part of 'picture_cubit.dart';

@immutable
sealed class PictureState {}

final class PictureInitial extends PictureState {}

final class GetPictureLoading extends PictureState {}

final class GetPictureSuccess extends PictureState {
  final PicModel picUrl;

  GetPictureSuccess({required this.picUrl});
}

final class GetPictureFailure extends PictureState {
  final String errorMessage;

  GetPictureFailure({required this.errorMessage});
}

final class AddPictureLoading extends PictureState {}
final class AddPictureSuccess extends PictureState {}
final class AddPictureFailure extends PictureState {
    final String errorMessage;

  AddPictureFailure({required this.errorMessage});

}

