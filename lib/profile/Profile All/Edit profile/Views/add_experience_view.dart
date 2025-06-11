import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/login/helper/text_filed.dart';
import 'package:shiftswift/profile/Cubits/experience%20cubit/experience_cubit.dart';
import 'package:shiftswift/profile/widgets/custom_button_profile.dart';

class AddExperienceView extends StatefulWidget {
  const AddExperienceView({super.key});

  @override
  State<AddExperienceView> createState() => _AddExperienceViewState();
}

class _AddExperienceViewState extends State<AddExperienceView> {
  final titleController = TextEditingController();
  final companyNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = dateFormat.format(picked);
    }
  }

  // @override
  // void dispose() {
  //   titleController.dispose();
  //   companyNameController.dispose();
  //   descriptionController.dispose();
  //   startDateController.dispose();
  //   endDateController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Experience'), centerTitle: true),
      body: BlocConsumer<ExperienceCubit, ExperienceState>(
        listener: (context, state)  {
          if (state is AddExperienceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.blue,
                content: Text('Experinece Added successfully!'),
              ),
            );
            Navigator.pop(context);
          } else if (state is AddExperienceFailure) {
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
                    hinText: 'Title',
                    controller: titleController,
                    icon: FontAwesomeIcons.briefcase,
                  ),
                  customTextField(
                    hinText: 'Company Name',
                    controller: companyNameController,
                    icon: FontAwesomeIcons.building,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, startDateController),
                    child: AbsorbPointer(
                      child: customTextField(
                        hinText: 'Start Date yyyy-MM-dd',
                        controller: startDateController,
                        icon: FontAwesomeIcons.calendarPlus,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, endDateController),
                    child: AbsorbPointer(
                      child: customTextField(
                        hinText: 'End Date yyyy-MM-dd',
                        controller: endDateController,
                        icon: FontAwesomeIcons.calendarCheck,
                      ),
                    ),
                  ),
                  customTextField(
                    hinText: 'Description',
                    controller: descriptionController,
                    icon: Icons.description,
                  ),
                  CustomButtonProfile(
                    text:(state is AddExperienceLoading)? 'Loading...':'Add Experience',
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<ExperienceCubit>(
                          context,
                        ).addExperience(
                          title: titleController.text,
                          companyName: companyNameController.text,
                          startDate: startDateController.text,
                          endDate: endDateController.text,
                          description: descriptionController.text,
                        );
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
