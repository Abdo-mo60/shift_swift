import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApplicantEducation extends StatelessWidget {
  const ApplicantEducation({super.key, required this.fieldOfStudy, required this.schoolName, required this.levelOfEducation});
final String fieldOfStudy;
final String schoolName;
final String levelOfEducation;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(FontAwesomeIcons.graduationCap),
            SizedBox(width: 8),
            Text(
              'Education',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          fieldOfStudy,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(schoolName),
        // Text('Level: $levelOfEducation'),
      ],
    );
  }

  
}