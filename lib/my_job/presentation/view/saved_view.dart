import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/service/service_locator.dart';
import 'package:shiftswift/home/data/repos/home_repo_impl.dart';
import 'package:shiftswift/home/presentation/manager/added_job_cubit.dart';
import 'package:shiftswift/home/presentation/view/job_description_view.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_button.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_rating.dart';
import 'package:shiftswift/home/presentation/view/widgets/home_view_item_top.dart';
import 'package:shiftswift/home/presentation/view/widgets/information_item.dart';
import '../../../home/presentation/view/widgets/home_view_item.dart';
import '../manager/my_job_cubit.dart';
import '../manager/my_job_state.dart';
import 'no_saved_view.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyJobCubit, MyJobState>(
      listener: (context, state) {
        if (state is RemoveSavedjobcubitSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('job Removed From Saved'),
              backgroundColor: AppColors.blue,
              behavior: SnackBarBehavior.floating,
            ),
          );
          BlocProvider.of<MyJobCubit>(context).getAllJob(memberId: currentId!);
        } else if (state is RemoveSavedjobcubitFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.erorrMessage),
              backgroundColor: AppColors.blue,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is MyJobSuccess) {
          if (state.jobs.isEmpty) {
            return NoSavedView();
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  spacing: 16,
                  children: List.generate(state.jobs.length, (index) {
                    return BlocProvider(
                      create:
                          (context) => Addedjobcubit(getIt.get<HomeRepoImpl>()),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 0.5,
                              color: AppColors.borderColor,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                HomeViewItemTop(
                                  imageUrl:
                                      state.jobs[index].jobDataModel.imageUrl!,
                                  title: state.jobs[index].jobDataModel.title,
                                  companyName:
                                      '${state.jobs[index].jobDataModel.companyFirstName} ${state.jobs[index].jobDataModel.companyLastName}',
                                ),
                                Divider(
                                  color: Color(0xff95948F),
                                  indent: 10,
                                  endIndent: 10,
                                  height: 20,
                                ),
                                InformationItem(
                                  text: state.jobs[index].jobDataModel.location,
                                  icon: Icons.location_on_outlined,
                                ),
                                SizedBox(height: 10),
                                InformationItem(
                                  text:
                                      state.jobs[index].jobDataModel.jobTypeTd,
                                  icon: Icons.schedule,
                                ),
                                SizedBox(height: 10),
                                InformationItem(
                                  text:
                                      "${state.jobs[index].jobDataModel.salary.toStringAsFixed(0)} EGP/${state.jobs[index].jobDataModel.salaryTypeId.name}",
                                  icon: Icons.money_sharp,
                                ),
                                SizedBox(height: 10),
                                CustomRating(
                                  rating:
                                      state.jobs[index].ratingModel.averageScore
                                          .toString(),
                                  review:
                                      state
                                          .jobs[index]
                                          .ratingModel
                                          .ratings!
                                          .length,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // SavedBlocConsumerButton(jobId: job.jobDataModel.id),
                                    CustomButton(
                                      text: 'Save',
                                      isIcon: true,
                                      onTap: () {
                                        BlocProvider.of<MyJobCubit>(
                                          context,
                                        ).removeFromSave(
                                          jobId:
                                              state.jobs[index].jobDataModel.jobId,
                                        );
                                      },
                                    ),
                                    CustomButton(
                                      text: 'View',
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return JobDescriptionView(
                                                job:
                                                    state
                                                        .jobs[index]
                                                        .jobDataModel,
                                                rating:
                                                    state
                                                        .jobs[index]
                                                        .ratingModel,
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
                  }),
                ),
              ),
            );
          }
        } else if (state is MyJobFailure) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
