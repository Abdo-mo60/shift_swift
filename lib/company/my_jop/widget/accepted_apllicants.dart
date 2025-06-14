import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/company/Cubits/all%20applicants%20for%20specific%20job%20cubit/all_applicants_for_job_cubit.dart';
import 'package:shiftswift/company/models/applicant_model.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/accepted_applicants_body.dart';
import 'package:shiftswift/company/my_jop/widget/applicant_intial_view.dart';
import 'package:shiftswift/company/my_jop/widget/no_applicant_applied.dart';

class AcceptedApllicants extends StatefulWidget {
  const AcceptedApllicants({super.key, this.jobId, this.jobModel});
  final String? jobId;
  final CompanyJobPostModel? jobModel;

  @override
  State<AcceptedApllicants> createState() => _AcceptedApplicantsState();
}

class _AcceptedApplicantsState extends State<AcceptedApllicants> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllSpecificApplicantsCubit>(
      context,
    ).getAllApplicantsForSpecificJob(jobId: widget.jobId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllSpecificApplicantsCubit, AllSpecificApplicantsState>(
      builder: (context, state) {
        if (state is AllSpecificApplicantsSuccess) {
          List<ApplicantModel> applicantsList =
              state.applicantModelList
                  .where((applicant) => applicant.status == 2)
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
                      child: AcceptedApplicantsBody(
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
