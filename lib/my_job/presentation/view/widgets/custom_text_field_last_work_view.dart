import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/styles.dart';

class CustomTextFieldLastWorkView extends StatelessWidget {
  const CustomTextFieldLastWorkView({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Any other suggestions?',
        hintStyle: GoogleFonts.lato(textStyle: AppStyles.regular14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
