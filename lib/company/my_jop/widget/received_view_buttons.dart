import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/company/Cubits/all%20applicants%20for%20specific%20job%20cubit/all_applicants_for_job_cubit.dart';
import 'package:shiftswift/company/Cubits/applicant%20details/applicant_details_cubit.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/applicant_profile.dart';
import 'package:shiftswift/company/my_jop/widget/short_list_bloc_consumer_button.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_button.dart';
import 'package:shiftswift/profile/Cubits/picture%20cubit/picture_cubit.dart';

class ReceivedViewButtons extends StatelessWidget {
  const ReceivedViewButtons({
    super.key,
    required this.jobId,
    required this.memberId,
    required this.jobModel,
  });
  final String jobId;
  final String memberId;

  final CompanyJobPostModel? jobModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlocProvider(
          create: (context) => AllSpecificApplicantsCubit(),
          child: ShortListBlocConsumerButton(jobId: jobId, memberId: memberId),
        ),

        CustomButton(
          text: 'View Profile',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => ApplicantDetailsCubit(),
                      ),
                      BlocProvider(
                        create: (context) => AllSpecificApplicantsCubit(),
                      ),
                       BlocProvider(
                        create: (context) => PictureCubit(),
                      ),
                    ],
                    child: ApplicantProfile(
                      jobModel: jobModel,
                      jobId: jobId,
                      applicantId: memberId,
                    ),
                  );
                },
              ),
            ).then((value) {
              BlocProvider.of<AllSpecificApplicantsCubit>(
                context,
              ).getAllApplicantsForSpecificJob(jobId: jobId);
            });
          },
        ),
      ],
    );
  }
}
