import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/profile/Cubits/user%20info%20cubit/user_info_cubit.dart';
import 'package:shiftswift/profile/Models/user_info_model.dart';

class ViewProfileTopBar extends StatelessWidget {
  const ViewProfileTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoModel usermodel =
        BlocProvider.of<UserInfoCubit>(context).userModel!;
    return Container(
      width: double.infinity,
      height: 150,
      color: AppColors.blue,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Spacer(flex: 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('asstes/d1.png'),
                ),
              ),
              Text(
                usermodel.userName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
