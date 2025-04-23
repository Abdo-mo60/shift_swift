import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/bottom_navigation_bar.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/login/authentication%20cubit/auth_cubit.dart';
import 'package:shiftswift/login/helper/TextFiled.dart';
import 'package:shiftswift/login/login_home.dart';

class RegisterUser extends StatefulWidget {
  RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  String accountType = '';
  String? _validateAccountType(String? value) {
    if (accountType.isEmpty) {
      return 'Please select an account type'; // Error message if no radio is selected
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomBottomNavigationBar()),
          );
        } else if (state is FailedToRegisterState) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  content: Text(
                    state.errorMessage,
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
                      "Sing Up",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 35),
                    customTextField(
                      icon: Icons.person,
                      hinText: 'User Name',
                      controller: nameController,
                    ),
                    SizedBox(height: 20),
                    customTextField(
                      hinText: 'Email',
                      controller: emailController,
                      icon: Icons.email,
                    ),
            
                    SizedBox(height: 20),
                    customTextField(
                      isScure: true,
                      hinText: 'Password',
                      controller: passwordController,
                      icon: Icons.lock_outline,
                    ),
                    SizedBox(height: 20),
                    customTextField(
                      hinText: 'Phone',
                      controller: phoneController,
                      icon: Icons.phone,
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
                          BlocProvider.of<AuthCubit>(context).register(
                            userName: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                            accountType: accountType,
                          );
                        }
                      },
                      child: Text(
                        "Register",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Already have an account?  ',
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginHome()),
                            );
                          },
                          child: Text(
                            'Logn in',
                            style: TextStyle(fontSize: 16, color: AppColors.blue),
                          ),
                        ),
                      ],
                    ),
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
