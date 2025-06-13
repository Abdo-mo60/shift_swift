import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/profile/Cubits/add%20update%20company%20data%20cubit/add_update_company_data_cubit.dart';
import 'package:shiftswift/profile/Cubits/add%20update%20person%20info/add_update_person_info_cubit.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Views/personal_info.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Views/company_info.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //  backgroundColor: AppColors.blue,
        elevation: 0,
        title: Text("Edit Profile", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          (accType == 'Member')

              ? 
              BlocProvider(
                create: (context) => AddUpdatePersonInfoCubit(),
                child: PersonalInfoPage(),
              )
              // ProfileSection(
              //   title: 'Personal Info',
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (_) => PersonalInfoPage()),
              //     );
              //   },
              // )
              // ProfileSection(
              //   title: 'Education',
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder:
              //             (_) => BlocProvider(
              //               create: (_) => EducationCubit(),
              //               child: AddEducationView(),
              //             ),
              //       ),
              //     );
              //   },
              // ),
              : BlocProvider(
                create: (context) => AddUpdateCompanyDataCubit(),
                child: CompanyInfoPage(),
              ),

      //  ProfileSection(
      //   title: 'info',
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) {
      //             return CompanyInfoPage();
      //           },
      //         ),
      //       );
      //     },
      //   ),
    );
  }
}
