import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/styles.dart';

class CustomTextFieldLastWorkView extends StatelessWidget {
  const CustomTextFieldLastWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Any other suggestions?',
        hintStyle: GoogleFonts.lato(textStyle: AppStyles.regular14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
