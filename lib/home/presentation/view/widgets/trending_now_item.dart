import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';

class TrendingNowItem extends StatelessWidget {
  const TrendingNowItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.trending_up_outlined, size: 16),
          SizedBox(width: 8),
          Text(
            'Trending Now',
            style: GoogleFonts.lato(textStyle: AppStyles.regular10),
          ),
        ],
      ),
    );
  }
}
