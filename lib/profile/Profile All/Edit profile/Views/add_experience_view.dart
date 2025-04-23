import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiftswift/login/helper/TextFiled.dart';
import 'package:shiftswift/profile/widgets/custom_button_profile.dart';

class AddExperienceView extends StatelessWidget {
  AddExperienceView({super.key});
  final titleController = TextEditingController();
  final companyNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Experience'), centerTitle: true),
      body: SingleChildScrollView(
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
            customTextField(
              hinText: 'Start MM/yy',
              controller: startDateController,
              icon: FontAwesomeIcons.clock,
            ),
            customTextField(
              hinText: 'End MM/yy',
              controller: endDateController,
              icon: FontAwesomeIcons.hourglassEnd,
            ),
            customTextField(
              hinText: 'Description',
              controller: descriptionController,
              icon: Icons.description,
            ),
            CustomButtonProfile(
              text: 'Add Experience',
              onTap: () {
                //Bloc Provider
                //Add Experience
              },
            ),
          ],
        ),
      ),
    );
  }
}
