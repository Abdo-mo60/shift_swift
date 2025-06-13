import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/my_job/presentation/view/widgets/custom_my_job_button.dart';
import 'package:shiftswift/profile/Cubits/change%20email%20cubit/change_email_cubit.dart';
import 'package:shiftswift/profile/Cubits/user%20info%20cubit/user_info_cubit.dart';

class ChangeEmailScreen extends StatefulWidget {
  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ChangeEmailCubit(userInfoCubit: context.read<UserInfoCubit>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Change Email"),
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
        body: BlocConsumer<ChangeEmailCubit, ChangeEmailState>(
          listener: (context, state) {
            if (state is ChangeEmailSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.blue,
                  content: Text('Email changed successfully!'),
                ),
              );
              Navigator.pop(context);
            } else if (state is ChangeEmailFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.blue,
                  content: Text(state.errorMessage),
                ),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text('Change Email Address',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  SizedBox(height: 12,),
                  Text(
                    "New Email Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      // label: Text('New Email Address'),
                      // hintText: "New Email Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomMyJobButton(
                    text: (state is ChangeEmailLoading)?"Loading...": "Save Changes",
                    onTap: () {
                      BlocProvider.of<ChangeEmailCubit>(
                        context,
                      ).changeEmail(newEmail: _emailController.text);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
