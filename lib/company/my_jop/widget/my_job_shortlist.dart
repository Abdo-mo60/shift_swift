import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/company/Cubits/all%20applicants%20for%20specific%20job%20cubit/all_applicants_for_job_cubit.dart';
import 'package:shiftswift/company/Cubits/applicant%20details/applicant_details_cubit.dart';
import 'package:shiftswift/company/models/applicant_details_model.dart';
import 'package:shiftswift/company/models/applicant_model.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/applicant_intial_view.dart';
import 'package:shiftswift/company/my_jop/widget/applicant_profile.dart';
import 'package:shiftswift/company/my_jop/widget/no_applicant_applied.dart';
import 'package:shiftswift/company/services/applicants_details_service.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_button.dart';
import 'package:shiftswift/home/presentation/view/widgets/information_item.dart';
import 'package:shiftswift/home/presentation/view/widgets/title_widget.dart';
import 'package:shiftswift/profile/Cubits/picture%20cubit/picture_cubit.dart';

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
    ).getShortListedApplicnts(jobID: widget.jobId ?? '');
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
          ).getShortListedApplicnts(jobID: widget.jobId ?? '');
        }
      },
      builder: (context, state) {
        if (state is GetApplicantShortListedSuccess) {
          return SingleChildScrollView(
            child: Column(
              children: List.generate(state.applicantsList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ShortListViewCompanyBody(
                    applicantModel: state.applicantsList[index],
                    jobModel: widget.jobPostModel!,
                  ),
                );
              }),
            ),
          );
        } else if (state is NoApplicantShortListed) {
          return NoApplicantApplied();
        } else if (state is GetShortListInitial) {
          return ApplicantIntialView();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class ShortListViewCompanyBody extends StatelessWidget {
  const ShortListViewCompanyBody({
    super.key,
    required this.applicantModel,
    required this.jobModel,
  });

  final ApplicantModel applicantModel;
  final CompanyJobPostModel jobModel;

  Future<ApplicantDetailsModel> _fetchApplicantDetails() {
    return ApplicantsDetailsService().getApplicantsDetails(
      jobId: jobModel.jobId!,
      applicantID: applicantModel.memberId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApplicantDetailsModel>(
      future: _fetchApplicantDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Error loading applicant data'),
          );
        }

        final details = snapshot.data!;
        final String name =
            (details.fullName?.trim().isEmpty ?? true)
                ? details.userName
                : details.fullName!;
        final String? imageUrl = details.imageUrl;

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
                  /// Top Row: Name + Job + Image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Name & Job Title
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleWidget(text: name),
                            Text(jobModel.title ?? ''),
                          ],
                        ),
                      ),

                      /// Applicant Image
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
                              imageUrl == ''
                                  ? Image.asset(
                                    'asstes/profile.png',
                                    fit: BoxFit.cover,
                                  )
                                  : Image.network(
                                    imageUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset('asstes/profile.png'),
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

                  /// Info Items
                  InformationItem(
                    text: jobModel.location ?? '',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 10),
                  InformationItem(
                    text: '${jobModel.jobType}/${jobModel.salaryType}',
                    icon: Icons.watch_later_outlined,
                  ),
                  const SizedBox(height: 10),
                  InformationItem(
                    text: '${jobModel.salary} EGP/${jobModel.salaryType}',
                    icon: Icons.money_sharp,
                  ),
                  const SizedBox(height: 10),

                  /// Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 145,
                        child: OutlinedButton(
                          onPressed: () {
                            BlocProvider.of<AllSpecificApplicantsCubit>(
                              context,
                            ).shortListApplicant(
                              jobId: jobModel.jobId!,
                              memberId: applicantModel.memberId,
                              status: 5,
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
                            "Remove From Short List",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
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
                                      create: (_) => ApplicantDetailsCubit(),
                                    ),
                                    BlocProvider(
                                      create:
                                          (_) => AllSpecificApplicantsCubit(),
                                    ),
                                    BlocProvider(
                                      create:
                                          (_) => PictureCubit(),
                                    ),
                                  ],
                                  child: ApplicantProfile(
                                    jobModel: jobModel,
                                    jobId: jobModel.jobId!,
                                    applicantId: applicantModel.memberId,
                                  ),
                                );
                              },
                            ),
                          ).then((_) {
                            BlocProvider.of<AllSpecificApplicantsCubit>(
                              context,
                            ).getShortListedApplicnts(jobID: jobModel.jobId!);
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
      },
    );
  }
}
