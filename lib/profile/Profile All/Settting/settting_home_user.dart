import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/profile/Models/user_info_model.dart';
import 'package:shiftswift/profile/Profile%20All/Settting/device_managment.dart';
import 'package:shiftswift/profile/Profile%20All/Settting/change_Email.dart';
import 'package:shiftswift/profile/Profile%20All/Settting/delet_account.dart';
import 'package:shiftswift/profile/Profile%20All/Settting/manage_2fa.dart';
import 'package:shiftswift/profile/Cubits/user%20info%20cubit/user_info_cubit.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Settings" , style: TextStyle(color: AppColors.blue),),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          BlocBuilder<UserInfoCubit, UserInfoState>(
            builder: (context, state) {
              if (state is UserInfoSuccess) {
                UserInfoModel usermodel =
                    BlocProvider.of<UserInfoCubit>(context).userModel!;
                return _buildSettingItem(
                  title: "Email",
                  subtitle: usermodel.email,
                  buttonText: "Change Email",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeEmailScreen(),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          // _buildSettingItem(
          //   title: "Two-Factor Authentication (2FA)",
          //   subtitle: "Disable",
          //   buttonText: "Manage 2FA",
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => TwoFactorAuthPage()),
          //     );
          //   },
          // ),
          // _buildSettingItem(
          //   title: "Block List",
          //   subtitle: "4 users",
          //   buttonText: "View",
          //   onPressed: () {
          //     print("View Block List Clicked");
          //   },
          // ),
          _buildSettingItem(
            title: "Device Management",
            subtitle: "",
            buttonText: "View",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceManagementPage(),
                ),
              );
            },
          ),
          // _buildSettingItem(
          //   title: "Delete Account",
          //   subtitle: "",
          //   buttonText: "Delete My Account",
          //   isDestructive: true,
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => DeleteAccountPage()),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    String? subtitle,
    required String buttonText,
    required VoidCallback onPressed,
    // bool isDestructive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (subtitle != null && subtitle.isNotEmpty)
                Text(subtitle, style: TextStyle(color: Colors.grey[700])),
            ],
          ),
          OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.blue,
              side: BorderSide(color: AppColors.blue),
            
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
