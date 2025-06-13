import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/service/service_locator.dart';
import '../../../data/models/home_model/job_model.dart';
import '../../../data/repos/home_repo_impl.dart';
import '../../manager/added_job_cubit.dart';
import '../job_description_view.dart';
import 'custom_button.dart';
import 'custom_rating.dart';
import 'home_view_item_top.dart';
import 'information_item.dart';
import 'saved_bloc_consumer_button.dart';

class HomeViewItem extends StatelessWidget {
  const HomeViewItem({super.key, required this.job});
  final JobModel job;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Addedjobcubit(getIt.get<HomeRepoImpl>()),
      child: Padding(
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
              children: [
                HomeViewItemTop(
                  imageUrl: job.jobDataModel.imageUrl!,
                  title: job.jobDataModel.title,
                  companyName: '${job.jobDataModel.companyFirstName} ${job.jobDataModel.companyLastName}',
                ),
                Divider(
                  color: Color(0xff95948F),
                  indent: 10,
                  endIndent: 10,
                  height: 20,
                ),
                InformationItem(
                  text: job.jobDataModel.location,
                  icon: Icons.location_on_outlined,
                ),
                SizedBox(height: 10),
                InformationItem(
                  text: job.jobDataModel.jobTypeTd,
                  icon: Icons.schedule,
                ),
                SizedBox(height: 10),
                InformationItem(
                  text:
                      "${job.jobDataModel.salary.toStringAsFixed(0)} EGP/${job.jobDataModel.salaryTypeId.name}",
                  icon: Icons.money_sharp,
                ),
                SizedBox(height: 10),
                CustomRating(
                  rating: job.ratingModel.averageScore.toString(),
                  review: job.ratingModel.ratings!.length,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SavedBlocConsumerButton(jobId: job.jobDataModel.id),
                    CustomButton(
                      text: 'View',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return JobDescriptionView(
                                job: job.jobDataModel,
                                rating: job.ratingModel,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
