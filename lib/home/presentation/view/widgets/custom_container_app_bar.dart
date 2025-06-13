import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/profile/Cubits/user%20info%20cubit/user_info_cubit.dart';
import 'package:shiftswift/profile/Models/user_info_model.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';


class CustomContainerAppBar extends StatefulWidget {
  const CustomContainerAppBar({super.key});

  @override
  State<CustomContainerAppBar> createState() => _CustomContainerAppBarState();
}

class _CustomContainerAppBarState extends State<CustomContainerAppBar> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserInfoCubit>(context).getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blue,
      height: 153,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<UserInfoCubit, UserInfoState>(
              builder: (context, state) {
                if (state is UserInfoSuccess) {
                  UserInfoModel userInfoModel=BlocProvider.of<UserInfoCubit>(context).userModel!;
                   return Text(
                        ' Hello,${userInfoModel.firstName} ${userInfoModel.lastName}' ,
                          style: GoogleFonts.lato(textStyle: AppStyles.bold20),
                        );
                }
                else{
                  return Center(child: CircularProgressIndicator(color: AppColors.white,));
                }
               
              },
            ),
          //  Icon(Icons.notifications_outlined, color: AppColors.main),
          ],
        ),
      ),
    );
  }
}
