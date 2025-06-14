import 'package:flutter/material.dart';
import 'package:shiftswift/company/models/applicant_model.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/home/presentation/view/widgets/information_item.dart';
import 'package:shiftswift/home/presentation/view/widgets/title_widget.dart';

class AcceptedApplicantsBody extends StatelessWidget {
  const AcceptedApplicantsBody({
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
                      child:
                          applicantModel.memberImageUrl == ''
                              ? Image.asset(
                                'asstes/images.jpg',
                                fit: BoxFit.cover,
                              )
                              : Image.network(
                                applicantModel.memberImageUrl!,
                                fit: BoxFit.cover,
                              ),
                    ),
                  ),
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
              InformationItem(text: applicantModel.phoneNumber, icon: Icons.phone),
              const SizedBox(height: 10),
              if (applicantModel.schoolName != '') ...[
                InformationItem(
                  text: '${applicantModel.schoolName}/${applicantModel.fieldOfStudy}',
                  icon: Icons.school,
                ),
              ],
              const SizedBox(height: 10),
              // ReceivedViewButtons(
              //   jobModel: jobModel,
              //   jobId: jobModel!.jobId!,
              //   memberId: applicantModel.memberId,
              // ),
            ],
          ),
        ),
      ),
    );
  }


}