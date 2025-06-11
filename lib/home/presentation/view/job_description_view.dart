import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/home/presentation/view/widgets/apply_now_botton.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_app_bar.dart';
import 'package:shiftswift/home/presentation/view/widgets/job_description_card.dart';
import 'package:shiftswift/home/presentation/view/widgets/job_infosection.dart';
import 'package:shiftswift/home/presentation/view/widgets/rating_cards.dart';
import 'package:shiftswift/home/presentation/view/widgets/review_header.dart';
import 'package:shiftswift/home/presentation/view/widgets/status_row.dart';
import 'package:shiftswift/profile/Cubits/reviews%20cubit/reviews_cubit.dart';
import 'package:shiftswift/profile/Profile%20All/MyReview/my_review.dart';
import '../../../core/app_colors.dart';
import '../../../core/model/job_data_model.dart';
import '../../../core/model/rating_model.dart';
import 'widgets/call_center.dart';
import 'widgets/hiring_team_card.dart';

class JobDescriptionView extends StatelessWidget {
  const JobDescriptionView({
    super.key,
    required this.job,
    required this.rating,
  });
  final JobDataModel job;
  final RatingModel rating;
  @override
  Widget build(BuildContext context) {
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
            CallCenterWidget(title: job.title, companyName: job.companyName!),
            SizedBox(height: 8),
            StatusRowWidget(postedOn: job.postedOn!),
            SizedBox(height: 8),
            JobDescriptionCard(
              description: job.description,
              location: job.location,
              salary: job.salary.toStringAsFixed(0),
              salaryType: job.salaryTypeId.name,
              jobType: job.jobTypeTd,
            ),
            SizedBox(height: 8),
            ReviewsHeader(
              onViewAllPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider(
                          create: (context) => ReviewsCubit(),
                          child: MyReviewsPage(companyId: job.companyId,),
                        ),
                  ),
                );
              },
            ),
            RatingCards(rating: rating),
            SizedBox(height: 24),
            HiringTeamCard(),
            SizedBox(height: 24),
            JobInfoSection(onLearnMore: () {}, onReportJob: () {}),
            ApplyNowButton(jobId: job.id),
          ],
        ),
      ),
    );
  }
}
