import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/profile/Cubits/experience%20cubit/experience_cubit.dart';
import 'package:shiftswift/profile/Cubits/education%20cubit/education_cubit.dart';
import 'package:shiftswift/profile/Cubits/skills%20cubit/skills_cubit.dart';
import 'package:shiftswift/profile/widgets/view_profile_education.dart';
import 'package:shiftswift/profile/widgets/view_profile_experience.dart';
import 'package:shiftswift/profile/widgets/view_profile_last_work.dart';
import 'package:shiftswift/profile/widgets/view_profile_skills.dart';
import 'package:shiftswift/profile/widgets/view_profile_top_bar.dart';
import 'package:shiftswift/profile/widgets/view_profile_user_contacts.dart';

class ProfilePerson extends StatelessWidget {
  const ProfilePerson({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EducationCubit()),
        BlocProvider(create: (context) => ExperienceCubit()),
        BlocProvider(create: (context) => SkillsCubit()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            ViewProfileTopBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  ViewProfileLastWork(),
                  const Divider(height: 20),
                  ViewProfileEducation(),
                  const Divider(height: 20),
                  ViewProfileExperience(),
                  const Divider(height: 20),
                  ViewProfileSkills(),
                  const Divider(height: 20),
                  ViewProfileUserContacts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
