import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/company/Cubits/all%20applicants%20for%20specific%20job%20cubit/all_applicants_for_job_cubit.dart';
import 'package:shiftswift/core/app_colors.dart';

class ShortListBlocConsumerButton extends StatelessWidget {
  const ShortListBlocConsumerButton({
    super.key,
    required this.jobId,
    required this.memberId,
  });
  final String jobId;
  final String memberId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllSpecificApplicantsCubit, AllSpecificApplicantsState>(
      listener: (context, state) {
        if (state is ApplicantShortListedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.blue,
              content: Text('Applicant Short Listed successfully!'),
            ),
          );
        } else if (state is ApplicantShortListedFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.blue,
              content: Text('Unable to Short List!'),
            ),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: 40,
          width: 160,
          child: OutlinedButton(
            onPressed: () {
              BlocProvider.of<AllSpecificApplicantsCubit>(
                context,
              ).shortListApplicant(jobId: jobId, memberId: memberId, status: 4);
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: const BorderSide(color: AppColors.blue),
              padding: const EdgeInsets.symmetric(vertical: 4),
            ),
            child: const Text(
              "Move To Short List",
              style: TextStyle(fontSize: 15,
              //  fontWeight: FontWeight.bold,
               ),
            ),
          ),
        );
      },
    );
  }
}
