import 'package:flutter/material.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Views/Personal.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Views/add_education_view.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Views/add_experience_view.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Views/add_skills_view.dart';
import 'package:shiftswift/profile/widgets/profile_section.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        elevation: 0,
        title: Text("Edit Profile", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   color: Colors.blue.shade800,
          //   padding: EdgeInsets.all(16),
          //   child: Row(
          //     children: [
          //       CircleAvatar(
          //         radius: 30,
          //         backgroundImage: AssetImage('asstes/three.png'), // استبدلها بالصورة الفعلية
          //       ),
          //       SizedBox(width: 12),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Abdelrahman mohamed",
          //             style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          //           ),
          //           Text(
          //             "Elmansora, Egypt",
          //             style: TextStyle(fontSize: 14, color: Colors.white70),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          ProfileSection(title: 'Personal Info', page: PersonalInfoPage()),
          ProfileSection(title: 'Education', page: AddEducationView()),
          ProfileSection(title: 'Experience', page: AddExperienceView()),
          ProfileSection(title: 'Skills', page: AddSkillsView()),
        ],
      ),
    );
  }
}
