import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/company/Cubits/all%20applicants%20for%20specific%20job%20cubit/all_applicants_for_job_cubit.dart';
import 'package:shiftswift/company/Cubits/applicant%20details/applicant_details_cubit.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/Applicants%20data/applicant_education.dart';
import 'package:shiftswift/company/my_jop/widget/Applicants%20data/applicant_last_work.dart';
import 'package:shiftswift/company/my_jop/widget/Applicants%20data/applicant_name_image.dart';
import 'package:shiftswift/company/my_jop/widget/Applicants%20data/applicants_contacts.dart';
import 'package:shiftswift/company/widgets/accept_reject_button.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/profile/Cubits/picture%20cubit/picture_cubit.dart';

class ApplicantProfile extends StatefulWidget {
  const ApplicantProfile({
    super.key,
    required this.jobId,
    required this.applicantId,
    required this.jobModel,
  });
  final String jobId;
  final String applicantId;
  final CompanyJobPostModel? jobModel;

  @override
  State<ApplicantProfile> createState() => _ApplicantProfileState();
}

class _ApplicantProfileState extends State<ApplicantProfile> {
  String? imageUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ApplicantDetailsCubit>(context).getApplicantsDetails(
      jobId: widget.jobId,
      applicantID: widget.applicantId,
    );
    BlocProvider.of<PictureCubit>(context).getPicUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<
        AllSpecificApplicantsCubit,
        AllSpecificApplicantsState
      >(
        listener: (context, state) {
          if (state is ApplyApplicantAccepted) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.green,
                  title: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 30,
                    child: Icon(Icons.check, size: 30, color: AppColors.green),
                  ),
                  content: Text(
                    "Applicant Accepted",
                    style: GoogleFonts.lato(textStyle: AppStyles.bold20),
                    textAlign: TextAlign.center,
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(color: AppColors.green, fontSize: 20),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is ApplyApplicantRejected) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.red,
                  title: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 30,
                    child: Icon(Icons.check, size: 30, color: AppColors.red),
                  ),
                  content: Text(
                    "Applicant Rejected",
                    style: GoogleFonts.lato(textStyle: AppStyles.bold20),
                    textAlign: TextAlign.center,
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(color: AppColors.red, fontSize: 20),
                      ),
                    ),
                  ],
                );
              },
            );
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     behavior: SnackBarBehavior.floating,
            //     backgroundColor: AppColors.red,
            //     content: Text('Applicant Rejected'),
            //   ),
            // );
          } else if (state is ApplyApplicantFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.blue,
                content: Text(state.errorMessage),
              ),
            );
          }
          // else if(state is ApplyApplicantLoading) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       behavior: SnackBarBehavior.floating,
          //       backgroundColor: AppColors.blue,
          //       content: Text('Loading...'),
          //     ),
          //   );
          // }
          // else{
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         behavior: SnackBarBehavior.floating,
          //         backgroundColor: AppColors.blue,
          //         content: Text('Error....'),
          //       ),
          //     );
          // }
        },
        builder: (context, state) {
          return BlocBuilder<ApplicantDetailsCubit, ApplicantDetailsState>(
            builder: (context, state) {
              if (state is ApplicantDetailsSuccess) {
                return Column(
                  children: [
                    ViewApplicantUserNameImage(
                      userName: state.applicantDetailsModel.fullName!,
                      imageUrl: state.applicantDetailsModel.imageUrl!,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      child: Column(
                        children: [
                          BlocBuilder<PictureCubit, PictureState>(
                            builder: (context, state) {
                              if (state is GetPictureSuccess) {
                                
                              return ApplicantLastWork(
                                sectionTitle: 'Request Received',
                                icon: Icon(Icons.edit_document),
                                title: '${widget.jobModel!.title}',
                                description: '${widget.jobModel!.description}',
                                postedOn: '${widget.jobModel!.postedOn}',
                                imageUrl: state.picUrl.picUrl,
                              );
                              }
                              else{
                                return CircularProgressIndicator();
                              }
                            }
                            ,
                          ),

                          if (state.applicantDetailsModel.title != '') ...[
                            SizedBox(height: 16,),
                            ApplicantLastWork(
                              sectionTitle: 'Last Work',
                              icon: Icon(Icons.reply),
                              title: state.applicantDetailsModel.title!,
                              description:
                                  state.applicantDetailsModel.description!,
                              postedOn: state.applicantDetailsModel.postedOn!,
                              imageUrl: state.applicantDetailsModel.lastWorkCompanyPic,
                            ),
                          ],
                          const Divider(height: 20),
                          if (state.applicantDetailsModel.levelOfEducation !=
                              '') ...[
                            ApplicantEducation(
                              fieldOfStudy:
                                  state.applicantDetailsModel.fieldOfStudy,
                              schoolName:
                                  state.applicantDetailsModel.schoolName,
                              levelOfEducation:
                                  state.applicantDetailsModel.levelOfEducation,
                            ),
                            const Divider(height: 20),
                          ],

                          // if (state.applicantDetailsModel.experienceTitle
                          //     is String) ...[
                          //   ApplicantExperience(
                          //     companyName:
                          //         state
                          //             .applicantDetailsModel
                          //             .experienceCompanyName,
                          //     title:
                          //         state.applicantDetailsModel.experienceTitle,
                          //     description:
                          //         state
                          //             .applicantDetailsModel
                          //             .experienceDescription,
                          //     startDateParsed:
                          //         state
                          //             .applicantDetailsModel
                          //             .experienceStartDate,
                          //     endDateParsed:
                          //         state.applicantDetailsModel.experienceEndDate,
                          //   ),
                          //   const Divider(height: 20),
                          // ],
                          // if (state.applicantDetailsModel.skills is String) ...[
                          //   ApplicantSkills(
                          //     skillName: state.applicantDetailsModel.skills,
                          //   ),
                          //   const Divider(height: 20),
                          // ],
                          ApplicantContacts(
                            location: state.applicantDetailsModel.location!,
                            phoneNumber:
                                state.applicantDetailsModel.phoneNumber,
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 32,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AcceptRejectButton(
                            onTap: () {
                              BlocProvider.of<AllSpecificApplicantsCubit>(
                                context,
                              ).applyApplicant(
                                jobId: widget.jobId,
                                memberId: widget.applicantId,
                                status: 3,
                              );
                            },
                            text: 'Reject',
                            color: AppColors.red,
                          ),
                          AcceptRejectButton(
                            onTap: () {
                              BlocProvider.of<AllSpecificApplicantsCubit>(
                                context,
                              ).applyApplicant(
                                jobId: widget.jobId,
                                memberId: widget.applicantId,
                                status: 2,
                              );
                            },
                            text: 'Accept',
                            color: AppColors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is ApplicantDetailsFailure) {
                return Center(child: Text(state.errorMessage));
              } else if (state is ApplicantDetailsLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Text('Uanble to get applicant Data!');
              }
            },
          );
        },
      ),
    );
  }
}
