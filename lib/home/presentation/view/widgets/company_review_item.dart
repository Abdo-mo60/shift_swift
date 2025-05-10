import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import 'custom_rating.dart';
import 'title_widget.dart';

class CompanyReviewItem extends StatelessWidget {
  const CompanyReviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Row(
            children: [
              Container(
                width: 35,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.main,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 0.5, color: AppColors.borderColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/images/im.png'),
                ),
              ),
              SizedBox(width: 8),
              TitleWidget(text: 'Abstergo Ltd', size: 14),
            ],
          ),
          CustomRating(rating: '', review: 0),
        ],
      ),
    );
  }
}
