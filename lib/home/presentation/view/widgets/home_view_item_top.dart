import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';
import 'title_widget.dart';
import 'trending_now_item.dart';

class HomeViewItemTop extends StatelessWidget {
  const HomeViewItemTop({
    super.key,
    required this.title,
    required this.companyName,
  });
  final String title;
  final String companyName;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 100, child: TrendingNowItem()),
              TitleWidget(text: title),
              Text(
                companyName,
                style: GoogleFonts.lato(textStyle: AppStyles.regular14),
              ),
            ],
          ),
        ),
        SizedBox(width: 30),
        Container(
          width: 74,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 0.5, color: AppColors.borderColor),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('asstes/im.png'),
          ),
        ),
      ],
    );
  }
}
