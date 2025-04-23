import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';

class CustomButtonProfile extends StatelessWidget {
  const CustomButtonProfile({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.blue,
            border: Border.all(color: Color(0xff20446A), width: 2),
          ),
          child: Text(
            text,
            style: GoogleFonts.lato(
              textStyle: AppStyles.medium20.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
