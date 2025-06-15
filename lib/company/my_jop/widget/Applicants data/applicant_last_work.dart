import 'package:flutter/material.dart';

class ApplicantLastWork extends StatelessWidget {
  const ApplicantLastWork({
    super.key,
    required this.title,
    required this.description,
    required this.postedOn,
    required this.sectionTitle,
    required this.icon,
    this.imageUrl,
  });
  final String title;
  final String description;
  final String postedOn;
  final String sectionTitle;
  final Icon icon;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [icon, Text(sectionTitle,style: TextStyle(fontSize: 17),)]),
        Row(
          children: [
            (imageUrl == '')
                ? Image.asset('asstes/images.jpg', width: 40, height: 40)
                : Image.network(imageUrl!,width: 40,height: 40,),
            SizedBox(width: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(description),
                // Text(postedOn),
                // Row(
                //   children: List.generate(
                //     5,
                //     (index) =>
                //         const Icon(Icons.star, color: Colors.amber, size: 18),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
