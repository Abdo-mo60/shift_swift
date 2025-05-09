import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:tap_to_expand/tap_to_expand.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';
import '../../../model/applied_job_model.dart';
import 'applied_job_stepper.dart';

class AppliedJobItem extends StatelessWidget {
  const AppliedJobItem({super.key, required this.appliedJobModel});
  final AppliedJobModel appliedJobModel;
  @override
  Widget build(BuildContext context) {
    return TapToExpand(
      backgroundcolor: AppColors.grey300,
      iconColor: AppColors.blue,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appliedJobModel.title,
            style: GoogleFonts.lato(textStyle: AppStyles.bold14),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Color(0xff4DD206).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                Icon(Icons.verified, size: 16, color: Color(0xff0D9300)),
                SizedBox(width: 8),
                Text(
                  'Application Sent ${timeago.format(appliedJobModel.postedOn)}',
                  style: GoogleFonts.lato(
                    textStyle: AppStyles.regular12.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: AppliedJobStepper(),
    );
  }
}
