import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/core/app_colors.dart';

import '../../../../core/service/service_locator.dart';
import '../../../../core/styles.dart';
import '../../../data/repos/home_repo_impl.dart';
import '../../manager/added_job_cubit.dart';
import 'ids.dart';

class ApplyNowButton extends StatelessWidget {
  const ApplyNowButton({super.key, required this.jobId});
  final String jobId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Addedjobcubit(getIt.get<HomeRepoImpl>()),
      child: BlocConsumer<Addedjobcubit, AddedjobState>(
        listener: (context, state) {
          if (state is AddedjobcubitSuccess) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.check, size: 30, color: Colors.white),
                  ),
                  content: Text(
                    "You have successfully applied for this job",
                    style: GoogleFonts.lato(textStyle: AppStyles.bold14),
                    textAlign: TextAlign.center,
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2D5C88),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          if (state is AddedjobcubitFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Job is already added'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.blue,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.read<Addedjobcubit>().appliedJob(
                    body: {"jobId": jobId, "memberId": Ids.memberId},
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D5C88),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Apply Now",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
