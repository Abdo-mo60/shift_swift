import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.text, this.size});
  final String text;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lato(
              textStyle: AppStyles.medium20.copyWith(
                color: AppColors.black,
                fontSize: size,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Icon(Icons.verified, color: AppColors.blue, size: 18),
      ],
    );
  }
}
