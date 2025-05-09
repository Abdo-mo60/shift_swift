import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart' show AppColors;

class JobInfoSection extends StatelessWidget {
  final VoidCallback onLearnMore;
  final VoidCallback onReportJob;

  const JobInfoSection({
    super.key,
    required this.onLearnMore,
    required this.onReportJob,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "At the side, we strive to make the job search process efficient, transparent, and secure. Start your journey today and let us help you find your dream job.",
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),

        Row(
          children: [
            TextButton(
              onPressed: onLearnMore,
              child: Text(
                "Learn More",
                style: TextStyle(color: AppColors.blue, fontSize: 13),
              ),
            ),
            Text("Or", style: TextStyle(fontSize: 12, color: Colors.grey)),
            TextButton(
              onPressed: onReportJob,
              child: Text(
                "Report This Job",
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.blue,
                  decorationThickness: 1.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
