
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApplicantExperience extends StatelessWidget {
  const ApplicantExperience({
    super.key,
    required this.title,
    required this.companyName,
    required this.startDateParsed,
    required this.endDateParsed,
    required this.description,
  });
  final String title;
  final String companyName;
  final String startDateParsed;
  final String endDateParsed;
  final String description;
  @override
  Widget build(BuildContext context) {
    DateTime endDate = DateTime.parse(endDateParsed);
    String formattedEndDate = DateFormat('MMM yyyy').format(endDate);
    DateTime startDate = DateTime.parse(startDateParsed);
    String formattedStartDate = DateFormat('MMM yyyy').format(startDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.work),
            SizedBox(width: 8),
            Text(
              'Experience',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          'Company: $companyName',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Title:$title', style: TextStyle(fontSize: 16)),
        Text('Description:$description', style: TextStyle(fontSize: 16)),

        Text('Start:$formattedStartDate', style: TextStyle(fontSize: 16)),
        Text('End: $formattedEndDate', style: TextStyle(fontSize: 16)),
      ],
    );
  }


}
