import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/core/app_colors.dart';
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
                  Text(
                    "Change Email Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "New Email Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ChangeEmailCubit>(
                        context,
                      ).changeEmail(newEmail: _emailController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child:(state is ChangeEmailLoading)?Text("Loading..."): Text("Save Changes"),
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
