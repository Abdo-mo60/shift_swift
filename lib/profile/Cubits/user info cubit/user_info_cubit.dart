import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/profile/Models/user_info_model.dart';
import 'package:shiftswift/profile/Services/get_user_info_service.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoInitial());
  UserInfoModel? userModel;

 Future<void> getUserInfo()
 async {
      try {
        userModel= await GetUserInfoService().getUserInfo();
        emit(UserInfoSuccess(usermodel: userModel!));
      } catch (e) {
         
        emit(UserInfoFailure(errorMessage: e.toString()));
      }
  }
 
}
