import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/login/helper/text_filed.dart';
import 'package:shiftswift/profile/Cubits/education%20cubit/education_cubit.dart';
import 'package:shiftswift/profile/widgets/custom_button_profile.dart';

class AddEducationView extends StatefulWidget {
  AddEducationView({super.key});

  @override
  State<AddEducationView> createState() => _AddEducationViewState();
}

class _AddEducationViewState extends State<AddEducationView> {
  final universityNameController = TextEditingController();
  final facultyController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedLevel;

  Widget buildLabeledField(String label, Widget field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(FontAwesomeIcons.graduationCap),
            SizedBox(width: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 6),
        field,
      ],
    );
  }

  InputDecoration customInputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  List<String> levels = [
    'High School',
    'Associate',
    'Bachelor',
    'Master',
    'Doctorate',
    'Professional',
  ];

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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  children: [
                    customTextField(
                      hinText: 'School Name',
                      controller: universityNameController,
                      icon: FontAwesomeIcons.buildingColumns,
                    ),
                    customTextField(
                      hinText: 'Field of study',
                      controller: facultyController,
                      icon: FontAwesomeIcons.bookOpen,
                    ),
                    buildLabeledField(
                      'Level of Education',
                      DropdownButtonFormField<String>(
                        decoration: customInputDecoration(),
                        items:
                            levels
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        value: selectedLevel,
                        onChanged: (value) {
                          setState(() => selectedLevel = value);
                        },
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Level must not be empty';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(height: 50),
                    CustomButtonProfile(
                      text:
                          (state is AddEducationLoading)
                              ? 'Loading...'
                              : 'Add Education',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<EducationCubit>(context).addEducation(
                            universityName: universityNameController.text,
                            level: selectedLevel!,
                            faculty: facultyController.text,
                          );
                          //Bloc Provider
                          //Add Education
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
