import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/home/presentation/view/widgets/title_widget.dart';
import 'package:shiftswift/home/presentation/view/widgets/trending_now_item.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';

class HomeViewItemTopCompany extends StatelessWidget {
  const HomeViewItemTopCompany({
    super.key,
    required this.title,
    required this.companyName,
    this.imageUrl,
  });
  final String title;
  final String companyName;
  final String? imageUrl;

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
        Container(
          width: 74,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 0.5, color: AppColors.borderColor),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                (imageUrl == '')
                    ? Image.asset('asstes/images.jpg',fit: BoxFit.cover,)
                    : Image.network(imageUrl!, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
