import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/company/Cubits/all%20applicants%20for%20specific%20job%20cubit/all_applicants_for_job_cubit.dart';
import 'package:shiftswift/company/models/applicant_model.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/applicant_intial_view.dart';
import 'package:shiftswift/company/my_jop/widget/no_applicant_applied.dart';
import 'package:shiftswift/company/my_jop/widget/received_view_body.dart';
import 'package:shiftswift/core/app_colors.dart';

class ReceivedViewCompany extends StatefulWidget {
  const ReceivedViewCompany({super.key, this.jobId, this.jobModel});
  final String? jobId;
  final CompanyJobPostModel? jobModel;

  @override
  State<ReceivedViewCompany> createState() => _ReceivedViewCompanyState();
}

class _ReceivedViewCompanyState extends State<ReceivedViewCompany> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllSpecificApplicantsCubit>(
      context,
    ).getAllApplicantsForSpecificJob(jobId: widget.jobId ?? '');
  }

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
          BlocProvider.of<AllSpecificApplicantsCubit>(
            context,
          ).getAllApplicantsForSpecificJob(jobId: widget.jobId ?? '');
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
        if (state is AllSpecificApplicantsSuccess) {
          List<ApplicantModel> applicantsList =
              state.applicantModelList
                  .where(
                    (applicant) =>
                        applicant.status != 2 &&
                        applicant.status != 3 &&
                        applicant.status != 4,
                  )
                  .toList();
          // final sortedJobApplicantsList =
          //   applicantsList
          //     ..sort((a, b) => b.appliedOn!.compareTo('${a.appliendOn}'));
          return applicantsList.isNotEmpty
              ? SingleChildScrollView(
                child: Column(
                  children: List.generate(applicantsList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ReceivedViewCompanyBody(
                        applicantModel: applicantsList[index],
                        jobModel: widget.jobModel,
                      ),
                    );
                  }),
                ),
              )
              : NoApplicantApplied();
        } else if (state is NoApplicantsAppliedForJob) {
          return NoApplicantApplied();
        } else if (state is AllSpecificApplicantsInitial) {
          return ApplicantIntialView();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
