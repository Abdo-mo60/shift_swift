import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/profile/Models/pic_model.dart';
import 'package:shiftswift/profile/Services/get_profile_pic_service.dart';

part 'picture_state.dart';

class PictureCubit extends Cubit<PictureState> {
  PictureCubit() : super(PictureInitial());
  PicModel? picModel;
  Future<void> getPicUrl()async{
    try {
      emit(GetPictureLoading());
     picModel= await ProfilePicService().getProfilePic();
      emit(GetPictureSuccess(picUrl: picModel!));
      
    } catch (e) {
      emit(GetPictureFailure(errorMessage: e.toString()));
    }
  }
  Future<void> uploadPic({required File imageFile})async{
    try {
      emit(AddPictureLoading());
      await ProfilePicService().uploadProfilePicture(imageFile:imageFile );
      emit(AddPictureSuccess());
      
    } catch (e) {
      emit(AddPictureFailure(errorMessage: e.toString()));
    }
  }
}
