import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shiftswift/profile/Services/change_email_service.dart';
import 'package:shiftswift/profile/user%20info%20cubit/user_info_cubit.dart';

part 'change_email_state.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailState> {
final UserInfoCubit userInfoCubit;
  ChangeEmailCubit({required this.userInfoCubit}) : super(ChangeEmailInitial());
 Future<void> changeEmail({required String newEmail})async{
try {
 await ChangeEmailService().changeEmail(newEmail: newEmail );

  emit(ChangeEmailSuccess());
  userInfoCubit.getUserInfo();
  
} catch (e) {
 emit(ChangeEmailFailure(
    errorMessage: e.toString().replaceFirst('Exception: ', ''),
  ));}


  }
}
