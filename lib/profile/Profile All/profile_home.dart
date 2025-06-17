import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/login/authentication%20cubit/auth_cubit.dart';
import 'package:shiftswift/login/login_home.dart';
import 'package:shiftswift/profile/Cubits/picture%20cubit/picture_cubit.dart';
import 'package:shiftswift/profile/Cubits/reviews%20cubit/reviews_cubit.dart';
import 'package:shiftswift/profile/Profile%20All/AboutUS/about_us.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Edit_profile_home.dart';
import 'package:shiftswift/profile/Profile%20All/HelpCenter/help_center.dart';
import 'package:shiftswift/profile/Profile%20All/MyReview/my_review.dart';
import 'package:shiftswift/profile/Profile%20All/Settting/settting_home_user.dart';
import 'package:shiftswift/profile/Services/get_profile_pic_service.dart';
import 'package:shiftswift/profile/widgets/user_profile_data.dart';

class ProfileHome extends StatelessWidget {
  const ProfileHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen();
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  Future<void> pickerCamera(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      await ProfilePicService().uploadProfilePicture(imageFile: imageFile!);
      // await ProfilePicService().getProfilePic();

      BlocProvider.of<PictureCubit>(context).getPicUrl();
    }
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text('Choose profile Photo', style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
                onPressed: () {
                  Navigator.pop(context);
                  pickerCamera(ImageSource.camera);
                },
              ),
              SizedBox(width: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.photo),
                label: const Text('Gallery'),
                onPressed: () {
                  Navigator.pop(context);
                  pickerCamera(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PictureCubit>(context).getPicUrl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LogOutStateSuccessfully) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginHome()),
            (Route<dynamic> route) => false,
          );
        } else if (state is FailedToLogOutState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(Icons.warning, size: 55, color: AppColors.red),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Failed to Sign out...Please Try Again!",
                      style: GoogleFonts.lato(textStyle: AppStyles.bold14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
              );
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Column(
          children: [
            Container(
              color: AppColors.blue,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Row(
                  children: [
                    BlocConsumer<PictureCubit, PictureState>(
                      listener: (context, state) {
                        if (state is GetPictureFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: AppColors.blue,
                              content: Text(state.errorMessage),
                            ),
                          );
                        } else if (state is AddPictureSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: AppColors.blue,
                              content: Text('Success picture!'),
                            ),
                          );
                        } else if (state is AddPictureLoading) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: AppColors.blue,
                              content: Text('Loading...!'),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is GetPictureSuccess) {
                          String url = state.picUrl.picUrl;
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return bottomSheet(context);
                                },
                              );
                            },
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  (url != '')
                                      ? NetworkImage(url)
                                      : AssetImage('asstes/profile.png'),
                            ),
                          );
                        } else if (state is GetPictureFailure) {
                          return Text(state.errorMessage);
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    const SizedBox(width: 15),
                    UserProfileData(),
                  ],
                ),
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  // if (accType == 'Member') ...[
                  //   _buildProfileOption(
                  //     Icons.person,
                  //     "View Profile",
                  //     context,
                  //     ProfilePerson(),
                  //   ),
                  // ]
                  if (accType == 'Company') ...[
                    _buildProfileOption(
                      Icons.star,
                      "My Review",
                      context,
                      BlocProvider(
                        create: (context) => ReviewsCubit(),
                        child: MyReviewsPage(companyId: currentId!),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],

                  _buildProfileOption(
                    Icons.edit,
                    "Edit Profile",
                    context,
                    EditProfileScreen(),
                  ),
                  SizedBox(height: 15),
                  _buildProfileOption(
                    Icons.settings,
                    "Settings",
                    context,
                    SettingsScreen(),
                  ),
                  SizedBox(height: 15),
                  _buildProfileOption(
                    Icons.help,
                    "Help Center",
                    context,
                    HelpCenterScreen(),
                  ),
                  SizedBox(height: 15),
                  _buildProfileOption(
                    Icons.info,
                    "About Us",
                    context,
                    AboutUsScreen(),
                  ),
                  SizedBox(height: 15),
                  _buildProfileOption(
                    Icons.logout,
                    "Sign Out",
                    context,
                    LoginHome(),
                    isLogout: true,
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildProfileOption(
  IconData icon,
  String title,
  BuildContext context,
  Widget page, {
  bool isLogout = false,
}) {
  return ListTile(
    leading: Icon(icon, color: AppColors.blue, size: 30),
    title: Text(title, style: TextStyle(color: AppColors.black, fontSize: 18)),
    trailing: Icon(Icons.arrow_forward_ios, size: 20, color: AppColors.grey400),
    onTap: () {
      if (isLogout == true) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 27,
                child: Icon(Icons.warning, size: 50, color: AppColors.blue),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Are you sure you want to sign out?",
                    style: GoogleFonts.lato(textStyle: AppStyles.bold16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: AppColors.blue, fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                  ),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).logOut();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      }
    },
  );
}
