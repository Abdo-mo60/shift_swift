import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/profile/Cubits/experience%20cubit/experience_cubit.dart';
import 'package:shiftswift/profile/Models/experience_model.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Views/add_experience_view.dart';

class ViewProfileExperience extends StatefulWidget {
  const ViewProfileExperience({super.key});

  @override
  State<ViewProfileExperience> createState() => _ViewProfileExperienceState();
}

class _ViewProfileExperienceState extends State<ViewProfileExperience> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExperienceCubit>(context).getExperience();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExperienceCubit, ExperienceState>(
      builder: (context, state) {
        if (state is GetExperienceSuccess) {
          ExperienceModel experienceModel =
              BlocProvider.of<ExperienceCubit>(context).experienceModel!;
          if (experienceModel.message == null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.work),
                    SizedBox(width: 8),
                    Text(
                      'Experience',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(flex: 1),
                    if (accType == 'Member')
                      IconButton(
                        onPressed: () {
                          //Delete method from using Expereince Bloc
                          BlocProvider.of<ExperienceCubit>(
                            context,
                          ).deleteExperience();
                        },
                        icon: Icon(FontAwesomeIcons.trash),
                      ),
                  ],
                ),
                Text(
                  'Company: ${experienceModel.companyName}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Title: ${experienceModel.title}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Description: ${experienceModel.description}',
                  style: TextStyle(fontSize: 16),
                ),

                Text(
                  'Start: ${experienceModel.startDate}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'End: ${experienceModel.endDate}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            );
          } else {
            // No experience UI
            return GoToAddExperience(experienceModel: experienceModel);
          }
        } else if (state is DeleteExperienceSuccess) {
          BlocProvider.of<ExperienceCubit>(context).getExperience();
          return Center(child: CircularProgressIndicator());
        } else if (state is GetExperienceFailure) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class GoToAddExperience extends StatelessWidget {
  const GoToAddExperience({super.key, required this.experienceModel});

  final ExperienceModel experienceModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(experienceModel.message ?? "No experience found."),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BlocProvider(
                      create: (context) => ExperienceCubit(),
                      child: AddExperienceView(),
                    ),
              ),
            ).then((_) {
              // This gets called when AddExperienceView is popped
              BlocProvider.of<ExperienceCubit>(context).getExperience();
            });
          },
          child: Text(
            "Go to Add Experience",
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
