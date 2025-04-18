import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/bottom_navigation_bar.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/login/authentication%20cubit/auth_cubit.dart';
import 'package:shiftswift/login/helper/TextFiled.dart';
import 'package:shiftswift/login/user/register_user.dart';

class LoginHome extends StatefulWidget {
  LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  String accountType = '';
  final fromKey = GlobalKey<FormState>();
  String? _validateAccountType(String? value) {
    if (accountType.isEmpty) {
      return 'Please select an account type'; 
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()),
          );
        } else if (state is FailedTOLoginState) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  content: Text(
                   ' ${state.errorMessage}or Account type',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: AppColors.blue,
                ),
          );
        }
        
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),

              child: Form(
                key: fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    coustmTextFailed(
                      hinText: 'UserName',
                      controller: userNameController,
                      icon: Icons.person,
                    ),

                    SizedBox(height: 20),
                    coustmTextFailed(
                      isScure: true,
                      hinText: 'Password',
                      controller: passwordController,
                      icon: Icons.lock_outline,
                    ),

                    SizedBox(height: 20),
                    FormField<String>(
                      validator: _validateAccountType,
                      builder: (FormFieldState<String> state) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildRadioOption(value: 'Member'),
                                _buildRadioOption(value: 'Company'),
                              ],
                            ),
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  state.errorText!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    MaterialButton(
                      onPressed: () {
                        if (fromKey.currentState!.validate()) {
                          // Register
                          // blocprovider
                          BlocProvider.of<AuthCubit>(context).login(
                            userName: userNameController.text,
                            password: passwordController.text,
                            accountType: accountType,
                          );
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: AppColors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textColor: Colors.white,
                      minWidth: double.infinity,
                    ),
                    SizedBox(height: 8),
                    // Center(
                    //   child: Text(
                    //     ' Don\'t have an account?  ',
                    //     style: TextStyle(fontSize: 14),
                    //   ),
                    // ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Don\'t have an account?',
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterUser(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text('Are you? Company ', style: TextStyle(fontSize: 14)),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => RegisterCompany(),
                    //           ),
                    //         );
                    //       },
                    //       child: Text(
                    //         'click here',
                    //         style: TextStyle(fontSize: 16, color: Colors.blue),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption({required String value}) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: accountType,
          onChanged: (newValue) {
            setState(() => accountType = newValue.toString());
          },
        ),
        Text(value),
        SizedBox(width: 20),
      ],
    );
  }
}
