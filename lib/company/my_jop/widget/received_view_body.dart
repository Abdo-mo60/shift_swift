import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/company/Cubits/all%20applicants%20for%20specific%20job%20cubit/all_applicants_for_job_cubit.dart';
import 'package:shiftswift/company/Cubits/applicant%20details/applicant_details_cubit.dart';
import 'package:shiftswift/company/models/applicant_model.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/applicant_profile.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_button.dart';
import 'package:shiftswift/home/presentation/view/widgets/information_item.dart';
import 'package:shiftswift/home/presentation/view/widgets/title_widget.dart';
import 'package:shiftswift/profile/Cubits/picture%20cubit/picture_cubit.dart';

class ReceivedViewCompanyBody extends StatelessWidget {
  const ReceivedViewCompanyBody({
    super.key,
    required this.applicantModel,
    required this.jobModel,
  });

  final ApplicantModel applicantModel;
  final CompanyJobPostModel? jobModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.5, color: AppColors.borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleWidget(
                          text:
                              (applicantModel.fullName == ' ')
                                  ? applicantModel.userName
                                  : applicantModel.fullName,
                        ),
                        Text('${jobModel!.title}'),
                      ],
                    ),
                  ),
                  if (applicantModel.memberImageUrl == '') ...[
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('asstes/profile.png'),
                    ),
                  ] else ...[
                    Container(
                      width: 74,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 0.5,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          applicantModel.memberImageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const Divider(
                color: Color(0xff95948F),
                indent: 10,
                endIndent: 10,
                height: 20,
              ),
              if (applicantModel.location != '') ...[
                InformationItem(
                  text: applicantModel.location,
                  icon: Icons.location_on_outlined,
                ),
              ],
              const SizedBox(height: 10),
              InformationItem(
                text: applicantModel.phoneNumber,
                icon: Icons.phone,
              ),
              const SizedBox(height: 10),
              if (applicantModel.schoolName != '') ...[
                InformationItem(
                  text:
                      '${applicantModel.schoolName}/${applicantModel.fieldOfStudy}',
                  icon: Icons.school,
                ),
              ],
              const SizedBox(height: 10),
              // ReceivedViewButtons(
              //   jobModel: jobModel,
              //   jobId: jobModel!.jobId!,
              //   memberId: applicantModel.memberId,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // BlocProvider(
                  //   create: (context) => AllSpecificApplicantsCubit(),
                  //   child: ShortListBlocConsumerButton(jobId: jobId, memberId: memberId),
                  // ),
                  SizedBox(
                    height: 40,
                    width: 160,
                    child: OutlinedButton(
                      onPressed: () {
                        BlocProvider.of<AllSpecificApplicantsCubit>(
                          context,
                        ).shortListApplicant(
                          jobId: jobModel!.jobId!,
                          memberId: applicantModel.memberId,
                          status: 4,
                        );
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
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
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
                                  create:
                                      (context) => AllSpecificApplicantsCubit(),
                                ),
                                BlocProvider(
                                  create: (context) => PictureCubit(),
                                ),
                              ],
                              child: ApplicantProfile(
                                jobModel: jobModel,
                                jobId: jobModel!.jobId!,
                                applicantId: applicantModel.memberId,
                              ),
                            );
                          },
                        ),
                      ).then((value) {
                        BlocProvider.of<AllSpecificApplicantsCubit>(
                          context,
                        ).getAllApplicantsForSpecificJob(
                          jobId: jobModel!.jobId!,
                        );
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
