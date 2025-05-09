import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';
import '../../../../home/presentation/view/widgets/home_view_item_top.dart';
import 'custom_my_job_button.dart';
import 'custom_text_field_last_work_view.dart';

class LastWorkViewItem extends StatelessWidget {
  const LastWorkViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          HomeViewItemTop(title: '', companyName: ''),
          Divider(
            color: Color(0xff95948F),
            indent: 10,
            endIndent: 10,
            height: 20,
          ),
          Text(
            'Rate your Last experience with us!',
            style: GoogleFonts.lato(textStyle: AppStyles.medium18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(Icons.star);
            }),
          ),
          SizedBox(height: 20),
          CustomTextFieldLastWorkView(),
          SizedBox(height: 20),
          CustomMyJobButton(text: 'Submit'),
        ],
      ),
    );
  }
}
