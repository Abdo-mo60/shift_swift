import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/profile/Cubits/education%20cubit/education_cubit.dart';
import 'package:shiftswift/profile/Models/education_model.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Views/add_education_view.dart';

class ViewProfileEducation extends StatefulWidget {
  const ViewProfileEducation({super.key});

  @override
  State<ViewProfileEducation> createState() => _ViewProfileEducationState();
}

class _ViewProfileEducationState extends State<ViewProfileEducation> {
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    if (accType=='Member') {
    BlocProvider.of<EducationCubit>(context).getEducation();
    }
  }

  @override
  Widget build(BuildContext context) {
    //eduction object from get education cubit
    return BlocBuilder<EducationCubit, EducationState>(
      builder: (context, state) {
        if (state is GetEducationSuccess) {
          EducationModel educationModel =
              BlocProvider.of<EducationCubit>(context).educationModel!;
          if (educationModel.message == null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.graduationCap),
                    SizedBox(width: 8),
                    Text(
                      'Education',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(flex: 1),
                    if (accType == 'Member')
                      IconButton(
                        onPressed: () {
                          //Delete method from using Education Bloc
                          BlocProvider.of<EducationCubit>(
                            context,
                          ).deleteEducation();
                        },
                        icon: Icon(FontAwesomeIcons.trash),
                      ),
                  ],
                ),
                Text(
                  'Field of study: ${educationModel.fieldOfStudy}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('School Name: ${educationModel.schoolName}'),
                Text('Level: ${educationModel.levelOfEducation}'),
              ],
            );
          } else {
            //No Education UI
            return GoToAddEducation(educationModel: educationModel);
          }
        } else if (state is DeleteEducationSuccess) {
          BlocProvider.of<EducationCubit>(context).getEducation();
          return Center(child: CircularProgressIndicator());
        } else if (state is GetEducationFailure) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class GoToAddEducation extends StatelessWidget {
  const GoToAddEducation({super.key, required this.educationModel});

  final EducationModel educationModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(educationModel.message ?? "No Education found."),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider(
                        create: (context) => EducationCubit(),
                        child: AddEducationView(),
                      ),
                ),
              ).then((_) {
                // This gets called when AddEducationView is popped
                BlocProvider.of<EducationCubit>(context).getEducation();
              });
            },
            child: Text(
              "Go to Add Education",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
