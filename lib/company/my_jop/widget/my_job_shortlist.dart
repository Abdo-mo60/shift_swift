import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/company/Cubits/all%20applicants%20for%20specific%20job%20cubit/all_applicants_for_job_cubit.dart';
import 'package:shiftswift/company/models/applicant_model.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/applicant_intial_view.dart';
import 'package:shiftswift/company/my_jop/widget/no_applicant_applied.dart';
import 'package:shiftswift/company/my_jop/widget/my_job_shortlist_body.dart';
import 'package:shiftswift/core/app_colors.dart';

class ShortListPage extends StatefulWidget {
  const ShortListPage({super.key, this.jobId, this.jobPostModel});
  final String? jobId;
  final CompanyJobPostModel? jobPostModel;

  @override
  State<ShortListPage> createState() => _ShortListPageState();
}

class _ShortListPageState extends State<ShortListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AllSpecificApplicantsCubit>(
      context,
    ).getAllApplicantsForSpecificJob(jobId: widget.jobId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllSpecificApplicantsCubit, AllSpecificApplicantsState>(
      listener: (context, state) {
        if (state is ApplicantRemovedShortListed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: AppColors.blue,
              content: Text('Applicant Removed From Short List!'),
            ),
          );
          BlocProvider.of<AllSpecificApplicantsCubit>(
            context,
          ).getAllApplicantsForSpecificJob(jobId: widget.jobId ?? '');
        }
      },
      builder: (context, state) {
        if (state is AllSpecificApplicantsSuccess) {
          List<ApplicantModel> applicantsList =
              state.applicantModelList
                  .where((applicant) => applicant.status == 4)
                  .toList();
           return applicantsList.isNotEmpty
              ? SingleChildScrollView(
                child: Column(
                  children: List.generate(applicantsList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ShortListViewCompanyBody(
                        applicantModel: applicantsList[index],
                        jobModel: widget.jobPostModel!,
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
