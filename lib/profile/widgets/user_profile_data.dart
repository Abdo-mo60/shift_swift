import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/profile/Models/user_info_model.dart';
import 'package:shiftswift/profile/Cubits/user%20info%20cubit/user_info_cubit.dart';

class UserProfileData extends StatefulWidget {
  const UserProfileData({super.key});

  @override
  State<UserProfileData> createState() => _UserProfileDataState();
}

class _UserProfileDataState extends State<UserProfileData> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserInfoCubit>(context).getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        if (state is UserInfoSuccess) {
        
          UserInfoModel usermodel =
              BlocProvider.of<UserInfoCubit>(context).userModel!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                usermodel.userName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                usermodel.email,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          );
        } else if (state is UserInfoFailure) {
          return CircularProgressIndicator(color: Colors.white,);
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       "No user name",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     Text(
          //       "No Email",
          //       style: TextStyle(color: Colors.white70, fontSize: 14),
          //     ),
          //   ],
          // );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}