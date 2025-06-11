import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/login/helper/text_filed.dart';
import 'package:shiftswift/profile/Cubits/skills%20cubit/skills_cubit.dart';
import 'package:shiftswift/profile/widgets/custom_button_profile.dart';

class AddSkillsView extends StatelessWidget {
  AddSkillsView({super.key});
  final skillsController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SkillsCubit, SkillsState>(
      listener: (context, state) {
        if (state is AddSkillsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.blue,
              content: Text('Skills Added successfully!'),
            ),
          );
          Navigator.pop(context);
        } else if (state is AddSkillsFailure) {
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
        return Scaffold(
          appBar: AppBar(title: Text('Skills'), centerTitle: true),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                customTextField(
                  hinText: 'Skills',
                  controller: skillsController,
                  icon: FontAwesomeIcons.award,
                ),
                CustomButtonProfile(
                  text:
                      (state is AddSkillsLoading) ? 'Loading...' : 'Add Skills',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      //Bloc Provider
                      //Add Skills
                      BlocProvider.of<SkillsCubit>(
                        context,
                      ).addSkills(skillName: skillsController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
