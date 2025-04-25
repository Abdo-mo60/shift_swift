import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiftswift/login/helper/TextFiled.dart';
import 'package:shiftswift/profile/widgets/custom_button_profile.dart';

class AddEducationView extends StatelessWidget {
  AddEducationView({super.key});
  final schoolNameController = TextEditingController();
  final levelOfEducationController = TextEditingController();
  final fieldOfStudyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Education'), centerTitle: true),
      body: SingleChildScrollView(
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
              text: 'Add Education',
              onTap: () {
                //Bloc Provider
                //Add Education
              },
            ),
          ],
        ),
      ),
    );
  }
}
