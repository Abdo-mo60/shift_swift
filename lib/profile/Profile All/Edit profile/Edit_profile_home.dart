import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/profile/Cubits/experience%20cubit/experience_cubit.dart';
import 'package:shiftswift/profile/Cubits/education%20cubit/education_cubit.dart';
import 'package:shiftswift/profile/Cubits/skills%20cubit/skills_cubit.dart';
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
          ProfileSection(
            title: 'Personal Info',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PersonalInfoPage()),
              );
            },
          ),
          ProfileSection(
            title: 'Education',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create: (_) => EducationCubit(),
                        child: AddEducationView(),
                      ),
                ),
              );
            },
          ),
          ProfileSection(
            title: 'Experience',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create: (context) => ExperienceCubit(),
                        child: AddExperienceView(),
                      ),
                ),
              );
            },
          ),
          ProfileSection(
            title: 'Skills',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create: (context) => SkillsCubit(),
                        child: AddSkillsView(),
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
