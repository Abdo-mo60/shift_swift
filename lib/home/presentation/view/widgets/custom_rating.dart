import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';

class CustomRating extends StatelessWidget {
  const CustomRating({super.key, required this.rating, required this.review});
  final String rating;
  final int review;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          // ignore: deprecated_member_use
          color: Color(0xFFD34E33).withOpacity(0.2),
          child: Row(
            children: [
              Text(rating == 'null' ? '0' : rating),
              SizedBox(width: 8),
              Icon(Icons.star, color: Colors.amber, size: 16),
            ],
          ),
        ),
        SizedBox(width: 8),
        Text(
          '($review Reviews)',
          style: GoogleFonts.lato(
            textStyle: AppStyles.medium14.copyWith(color: AppColors.blue),
          ),
        ),
      ],
    );
  }
}
