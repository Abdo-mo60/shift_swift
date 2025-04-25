import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiftswift/login/helper/TextFiled.dart';
import 'package:shiftswift/profile/widgets/custom_button_profile.dart';

class AddSkillsView extends StatelessWidget {
  AddSkillsView({super.key});
  final skillsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Skills'), centerTitle: true),
      body: Column(
        children: [
          customTextField(
            hinText: 'Skills',
            controller: skillsController,
            icon: FontAwesomeIcons.award,
          ),
          CustomButtonProfile(
            text: 'Add Skills',
            onTap: () {
              //Bloc Provider
              //Add Skills
            },
          ),
        ],
      ),
    );
  }
}
