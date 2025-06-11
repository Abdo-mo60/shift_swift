import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApplicantSkills extends StatelessWidget {
  const ApplicantSkills({super.key, required this.skillName});
  final String skillName;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(FontAwesomeIcons.award),
            SizedBox(width: 8),
            Text(
              'Skills',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(skillName, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
