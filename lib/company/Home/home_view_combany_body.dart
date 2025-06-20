import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/company/Cubits/applicant%20details/applicant_details_cubit.dart';
import 'package:shiftswift/company/Cubits/company%20job%20posts%20cubit/company_job_posts_cubit.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/myjob_company.dart';
import 'package:shiftswift/company/widgets/home_view_item_top_company.dart';
import 'package:shiftswift/company/widgets/no_jobs_view.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_app_bar.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_button.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_container_app_bar.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_rating.dart';
import 'package:shiftswift/home/presentation/view/widgets/hiring_team_card.dart';
import 'package:shiftswift/home/presentation/view/widgets/information_item.dart';
import 'package:shiftswift/home/presentation/view/widgets/job_description_card.dart';
import 'package:shiftswift/home/presentation/view/widgets/job_infosection.dart';
import 'package:shiftswift/home/presentation/view/widgets/review_header.dart';
import 'package:shiftswift/home/presentation/view/widgets/status_row.dart';
import 'package:shiftswift/profile/Cubits/picture%20cubit/picture_cubit.dart';
import 'package:shiftswift/profile/Cubits/reviews%20cubit/reviews_cubit.dart';
import 'package:shiftswift/profile/Cubits/user%20info%20cubit/user_info_cubit.dart';
import 'package:shiftswift/profile/Models/reviews_model.dart';
import 'package:shiftswift/profile/Models/user_info_model.dart';
import 'package:shiftswift/profile/Profile%20All/MyReview/my_review.dart';

class HomeViewCompanyBody extends StatelessWidget {
  const HomeViewCompanyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              CustomContainerAppBar(),
              // SizedBox(height: 12),
              MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => ReviewsCubit()),
                  BlocProvider(create: (context) => PictureCubit()),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: HomeViewItemCompanyColumn(),
                ),
              ),
            ],
          ),
          // Positioned(top: 100, left: 20, right: 20, child: PostJobBar()),
        ],
      ),
    );
  }
}

class HomeViewItemCompanyColumn extends StatefulWidget {
  const HomeViewItemCompanyColumn({super.key});

  @override
  State<HomeViewItemCompanyColumn> createState() =>
      _HomeViewItemCompanyColumnState();
}

class _HomeViewItemCompanyColumnState extends State<HomeViewItemCompanyColumn> {
  List<CompanyJobPostModel> jobPostList = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CompanyJobPostsCubit>(context).getAllJobPostsForComapny();
    // BlocProvider.of<ReviewsCubit>(context).getReviews(companyId: currentId!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyJobPostsCubit, CompanyJobPostsState>(
      listener: (context, state) {
        if (state is DeleteCompanyJobPostsSuccess) {
          setState(() {
            jobPostList.removeWhere((job) => job.jobId == state.jobId);
          });
          //   BlocProvider.of<CompanyJobPostsCubit>(context).getAllJobPostsForComapny();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.blue,
              content: Text("Job deleted successfully"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is GetCompanyJobPostsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.blue,
              content: Text(state.errorMessage),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is CreateJobPostsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.blue,
              content: Text("Job Created successfully"),
              behavior: SnackBarBehavior.floating,
            ),
          );
          BlocProvider.of<CompanyJobPostsCubit>(
            context,
          ).getAllJobPostsForComapny();
        }
      },
      child: BlocBuilder<CompanyJobPostsCubit, CompanyJobPostsState>(
        builder: (context, state) {
          if (state is GetCompanyJobPostsSuccess) {
            if (state.jobPostList[0].message == null) {
  
              jobPostList = state.jobPostList;
              final sortedJobPostList =
                  jobPostList
                    ..sort((a, b) => b.postedOn!.compareTo('${a.postedOn}'));

              return Column(
                children: List.generate(sortedJobPostList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: HomeViewItem(
                      jobPostModel: sortedJobPostList[index],
                      avgRatingScore: state.jobPostList[0].avgRatingScore,
                      numberOfReviews: state.jobPostList[0].numberOfReviews,
                    ),
                  );
                }),
              );
            } else {
              //no jobs found
              return NoJobsView();
            }
          } else if (state is DeleteCompanyJobPostsSuccess) {
            if (jobPostList.isEmpty) {
              return NoJobsView();
            } else if (jobPostList.isNotEmpty) {
              return Column(
                children: List.generate(jobPostList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: HomeViewItem(
                      jobPostModel: jobPostList[index],
                      avgRatingScore: jobPostList[0].avgRatingScore,
                      numberOfReviews: jobPostList[0].numberOfReviews,
                    ),
                  );
                }),
              );
            } else {
              return CircularProgressIndicator();
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class HomeViewItem extends StatefulWidget {
  const HomeViewItem({
    super.key,
    required this.jobPostModel,
    required this.avgRatingScore,
    required this.numberOfReviews,
  });
  final CompanyJobPostModel jobPostModel;
  final numberOfReviews;
  final double avgRatingScore;

  @override
  State<HomeViewItem> createState() => _HomeViewItemState();
}

class _HomeViewItemState extends State<HomeViewItem> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PictureCubit>(context).getPicUrl();
  }

  late String picUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.5, color: AppColors.borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<PictureCubit, PictureState>(
                builder: (context, state) {
                  if (state is GetPictureSuccess) {
                    picUrl =
                        BlocProvider.of<PictureCubit>(context).picModel!.picUrl;
                    UserInfoModel userInfoModel =
                        BlocProvider.of<UserInfoCubit>(context).userModel!;
                    return HomeViewItemTopCompany(
                      imageUrl: state.picUrl.picUrl,
                      title: '${widget.jobPostModel.title}',
                      companyName:
                          '${userInfoModel.firstName} ${userInfoModel.lastName}',
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              Divider(
                color: Color(0xff95948F),
                indent: 10,
                endIndent: 10,
                height: 20,
              ),
              InformationItem(
                text: '${widget.jobPostModel.location}',
                icon: Icons.location_on_outlined,
              ),
              SizedBox(height: 10),
              InformationItem(
                text:
                    '${widget.jobPostModel.jobType}/${widget.jobPostModel.workMode}',
                icon: Icons.schedule,
              ),
              SizedBox(height: 10),
              InformationItem(
                text:
                    '${widget.jobPostModel.salary} EGP/${widget.jobPostModel.salaryType}',
                icon: Icons.money_sharp,
              ),
              SizedBox(height: 10),
              CustomRating(
                rating: '${widget.avgRatingScore}',
                review: widget.numberOfReviews,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'View Applicants',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(create: (context) => ReviewsCubit()),
                          ],

                          child: JobDescriptionViewCompany(
                            imageUrl: picUrl,
                            jobPostModel: widget.jobPostModel,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     SizedBox(
              //       height: 40,
              //       width: 145,
              //       child: OutlinedButton(
              //         onPressed: () {
              //           BlocProvider.of<CompanyJobPostsCubit>(
              //             context,
              //           ).deleteJobPostForCompany(
              //             jobId: '${widget.jobPostModel.jobId}',
              //           );
              //         },
              //         style: OutlinedButton.styleFrom(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30),
              //           ),
              //           side: const BorderSide(color: AppColors.blue),
              //           padding: const EdgeInsets.symmetric(horizontal: 24),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: [
              //             const Text(
              //               "Delete",
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             Icon(FontAwesomeIcons.trash),
              //           ],
              //         ),
              //       ),
              //     ),
              //     CustomButton(
              //       text: 'View',
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) {
              //               return MultiBlocProvider(
              //                 providers: [
              //                   BlocProvider(
              //                     create: (context) => ReviewsCubit(),
              //                   ),
              //                 ],

              //                 child: JobDescriptionViewCompany(
              //                   imageUrl:picUrl,
              //                   jobPostModel: widget.jobPostModel,
              //                 ),
              //               );
              //             },
              //           ),
              //         );
              //       },
              //     ),
              //   ],
              // ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class JobDescriptionViewCompany extends StatefulWidget {
  const JobDescriptionViewCompany({
    super.key,
    required this.jobPostModel,
    required this.imageUrl,
  });
  final CompanyJobPostModel jobPostModel;
  final String imageUrl;

  @override
  State<JobDescriptionViewCompany> createState() =>
      _JobDescriptionViewCompanyState();
}

class _JobDescriptionViewCompanyState extends State<JobDescriptionViewCompany> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReviewsCubit>(context).getReviews(companyId: currentId!);
  }

  @override
  Widget build(BuildContext context) {
    UserInfoModel userInfoModel =
        BlocProvider.of<UserInfoCubit>(context).userModel!;
    return Scaffold(
      backgroundColor: AppColors.main,
      appBar: CustomAppBar(
        onClose: () {
          Navigator.pop(context);
        },
        onMorePressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CallCenterWidgetCompany(
              imageUrl: widget.imageUrl,
              title: '${widget.jobPostModel.title}',
              companyName:
                  '${userInfoModel.firstName} ${userInfoModel.lastName}',
            ),
            // SizedBox(height: 8),
            // StatusRowWidget(postedOn: DateTime.now()),
            // SizedBox(height: 8),
            JobDescriptionCard(
              description: '${widget.jobPostModel.description}',
              location: '${widget.jobPostModel.location}',
              salary: '${widget.jobPostModel.salary}',
              salaryType: '${widget.jobPostModel.salaryType}',
              jobType:
                  '${widget.jobPostModel.jobType}/${widget.jobPostModel.workMode}',
            ),
           Center(
              child: Card(
                color: AppColors.grey200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0.5,
                margin: EdgeInsets.all(5),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Requirements",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      ..._buildJobResponsibilities(
                        description: widget.jobPostModel.requirements!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            BlocBuilder<ReviewsCubit, ReviewsState>(
              builder: (context, state) {
                if (state is ReviewsSuccess) {
                  return Column(
                    children: [
                      ReviewsHeader(
                        onViewAllPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BlocProvider(
                                    create: (context) => ReviewsCubit(),
                                    child: MyReviewsPage(companyId: currentId!),
                                  ),
                            ),
                          );
                        },
                      ),

                      ReviewCards(ratingModelList: state.reviewsList),
                    ],
                  );
                } else if (state is NoReviews) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.grey300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      spacing: 16,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return Icon(Icons.star_border, color: Colors.grey);
                          }),
                        ),
                        Text(
                          "No Rating For this",
                          style: GoogleFonts.lato(textStyle: AppStyles.bold18),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: 24),
            // HiringTeamCard(),
            // SizedBox(height: 24),
            JobInfoSection(onLearnMore: () {}, onReportJob: () {}),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider(
                          create: (context) => ApplicantDetailsCubit(),
                          child: MyJobViewCompany(
                            jobId: widget.jobPostModel.jobId,
                            jobModel: widget.jobPostModel,
                          ),
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "View Applicants",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _buildJobResponsibilities({required String description}) {
  List<String> responsibilities = [description];
  return responsibilities
      .map(
        (text) => Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Icon(Icons.circle, size: 8, color: AppColors.grey400),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      )
      .toList();
}

class ReviewCards extends StatelessWidget {
  const ReviewCards({super.key, required this.ratingModelList});
  final List<ReviewsModel> ratingModelList;
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> ratings = List.generate(
      ratingModelList.length,
      (index) => {
        "rating": ratingModelList[index].score,
        "reviews": ratingModelList[index].comment,
      },
    );

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ratings.length,
        itemBuilder: (context, index) {
          final rating = ratings[index];

          return IntrinsicWidth(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.grey200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.lightyellow,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          rating["rating"].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.star, color: Colors.amber, size: 22),
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 250),
                    child: Text(
                      rating["reviews"],
                      style: TextStyle(color: Colors.grey[700], fontSize: 15),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CallCenterWidgetCompany extends StatelessWidget {
  const CallCenterWidgetCompany({
    super.key,
    required this.title,
    required this.companyName,
    this.imageUrl,
  });
  final String title;
  final String companyName;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child:
                imageUrl == ''
                    ? Image.asset('asstes/images.jpg')
                    : Image.network(imageUrl!, width: 80),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 5),
              Icon(Icons.verified, color: Colors.blue, size: 20),
            ],
          ),
          SizedBox(height: 8),
          Text(
            companyName,
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
