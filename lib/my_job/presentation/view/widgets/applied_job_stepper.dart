import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/styles.dart';
import 'custom_step.dart';

class AppliedJobStepper extends StatefulWidget {
  const AppliedJobStepper({super.key});

  @override
  State<AppliedJobStepper> createState() => _AppliedJobStepperState();
}

int activeStep = 1;
List<String> titles = [
  'Application Sent',
  'Application viewed',
  'Application Shortlisted',
];

class _AppliedJobStepperState extends State<AppliedJobStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 0.5, color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Application Status',
            style: GoogleFonts.lato(textStyle: AppStyles.medium20),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(titles.length, (index) {
                return CustomStep(
                  title: titles[index],
                  index: index,
                  activeStep: activeStep,
                  length: titles.length,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
