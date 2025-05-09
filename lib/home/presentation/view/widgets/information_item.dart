import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';

class InformationItem extends StatelessWidget {
  const InformationItem({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: [
        Icon(icon, size: 20, color: AppColors.grey400),
        Text(
          text,
          style: GoogleFonts.lato(
            textStyle: AppStyles.regular14.copyWith(color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
