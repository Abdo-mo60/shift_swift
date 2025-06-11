
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApplicantContacts extends StatelessWidget {
  const ApplicantContacts({
    super.key,
    required this.phoneNumber,
    required this.location,
  });
  final String phoneNumber;
  final String location;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(FontAwesomeIcons.phone),
                        SizedBox(width: 10,),

            const Text(
              'Phone Number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          phoneNumber,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20,),
        if(location!='')...[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(FontAwesomeIcons.locationPin),
            SizedBox(width: 10,),
            const Text(
              'Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(location, textAlign: TextAlign.start, style: TextStyle(fontSize: 16)),
      ],]
    );
  }
}
