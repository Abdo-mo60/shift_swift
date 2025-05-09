import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';


class CustomContainerAppBar extends StatelessWidget {
  const CustomContainerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blue,
      height: 153,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hello, Karim',
              style: GoogleFonts.lato(textStyle: AppStyles.bold20),
            ),
            Icon(Icons.notifications_outlined, color: AppColors.main),
          ],
        ),
      ),
    );
  }
}
