import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/company/Cubits/applicant%20details/applicant_details_cubit.dart';
import 'package:shiftswift/company/models/applicant_details_model.dart';
import 'package:shiftswift/company/models/applicant_model.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/received_view_buttons.dart';
import 'package:shiftswift/company/services/applicants_details_service.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/home/presentation/view/widgets/information_item.dart';
import 'package:shiftswift/home/presentation/view/widgets/title_widget.dart';
class ReceivedViewCompanyBody extends StatelessWidget {
  const ReceivedViewCompanyBody({
    super.key,
    required this.applicantModel,
    required this.jobModel,
  });

  final ApplicantModel applicantModel;
  final CompanyJobPostModel? jobModel;

  Future<ApplicantDetailsModel> _fetchApplicantDetails() {
    return ApplicantsDetailsService().getApplicantsDetails(
      jobId: jobModel!.jobId!,
      applicantID: applicantModel.memberId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApplicantDetailsModel>(
      future: _fetchApplicantDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error loading applicant data');
        }

        final details = snapshot.data!;
        return _buildApplicantCard(details);
      },
    );
  }

  Widget _buildApplicantCard(ApplicantDetailsModel details) {
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                        text: (details.fullName == null || details.fullName!.trim().isEmpty)
                            ? details.userName
                            : details.fullName!,
                      ),
                      Text('${jobModel!.title}'),
                    ],
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
                      child: details.imageUrl == ''
                          ? Image.asset('asstes/profile.png', fit: BoxFit.cover)
                          : Image.network(details.imageUrl!, fit: BoxFit.cover),
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
              InformationItem(
                text: '${jobModel!.location}',
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 10),
              InformationItem(
                text: '${jobModel!.jobType}/${jobModel!.salaryType}',
                icon: Icons.watch_later_outlined,
              ),
              const SizedBox(height: 10),
              InformationItem(
                text: '${jobModel!.salary} EGP/${jobModel!.salaryType}',
                icon: Icons.money_sharp,
              ),
              const SizedBox(height: 10),
              ReceivedViewButtons(
                jobModel: jobModel,
                jobId: jobModel!.jobId!,
                memberId: applicantModel.memberId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
