import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/login/helper/TextFiled.dart';
import 'package:shiftswift/profile/Cubits/education%20cubit/education_cubit.dart';
import 'package:shiftswift/profile/widgets/custom_button_profile.dart';

class AddEducationView extends StatelessWidget {
  AddEducationView({super.key});
  final schoolNameController = TextEditingController();
  final levelOfEducationController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Education'), centerTitle: true),
      body: BlocConsumer<EducationCubit, EducationState>(
        listener: (context, state) {
          if (state is AddEducationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.blue,
                content: Text('Education Added successfully!'),
              ),
            );
            Navigator.pop(context);
          } else if (state is AddEducationFailure) {
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
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  customTextField(
                    hinText: 'School Name',
                    controller: schoolNameController,
                    icon: FontAwesomeIcons.buildingColumns,
                  ),
                  customTextField(
                    hinText: 'Level of Education',
                    controller: levelOfEducationController,
                    icon: FontAwesomeIcons.graduationCap,
                  ),
                  customTextField(
                    hinText: 'Field of study',
                    controller: fieldOfStudyController,
                    icon: FontAwesomeIcons.bookOpen,
                  ),

                  SizedBox(height: 50),
                  CustomButtonProfile(
                    text:
                        (state is AddEducationLoading)
                            ? 'Loading...'
                            : 'Add Education',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<EducationCubit>(
                          context,
                        ).addEducation(
                          schoolName: schoolNameController.text,
                          levelOfEducation: levelOfEducationController.text,
                          fieldOfStudy: fieldOfStudyController.text,
                        );
                        //Bloc Provider
                        //Add Education
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
