import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
class ReviewsHeader extends StatelessWidget {
  final VoidCallback onViewAllPressed;

  const ReviewsHeader({super.key, required this.onViewAllPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Reviews', style: TextStyle(fontSize: 25)),
        TextButton(
          onPressed: onViewAllPressed,
          child: Text(
            'View All',
            style: TextStyle(
              color: AppColors.blue,
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.blue,
              decorationThickness: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
