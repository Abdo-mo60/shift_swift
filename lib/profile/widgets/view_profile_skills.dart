import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/profile/Cubits/skills%20cubit/skills_cubit.dart';
import 'package:shiftswift/profile/Models/skills_model.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Views/add_skills_view.dart';

class ViewProfileSkills extends StatefulWidget {
  const ViewProfileSkills({super.key});

  @override
  State<ViewProfileSkills> createState() => _ViewProfileSkillsState();
}

class _ViewProfileSkillsState extends State<ViewProfileSkills> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SkillsCubit>(context).getSkills();
  }

  @override
  Widget build(BuildContext context) {
    //skill object from get skill cubit and probably init state
    return BlocBuilder<SkillsCubit, SkillsState>(
      builder: (context, state) {
        if (state is GetSkillsSuccess) {
          SkillsModel skillsModel =
              BlocProvider.of<SkillsCubit>(context).skillsModel!;
          if (skillsModel.message == null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.award),
                    SizedBox(width: 8),
                    Text(
                      'Skills',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(flex: 1),
                    if(accType=='Member')
                    IconButton(
                      onPressed: () {
                        //Delete method from using skils cubit
                        BlocProvider.of<SkillsCubit>(context).delteSkills();
                      },
                      icon: Icon(FontAwesomeIcons.trash),
                    ),
                  ],
                ),
                Text('${skillsModel.name}', style: TextStyle(fontSize: 16)),
              ],
            );
          } else {
            //no skills UI
            return GoToAddSkills(skillsModel: skillsModel);
          }
        } else if (state is DeleteSkillsSuccess) {
          BlocProvider.of<SkillsCubit>(context).getSkills();
          return Center(child: CircularProgressIndicator());
        } else if (state is GetSkillsFailure) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class GoToAddSkills extends StatelessWidget {
  const GoToAddSkills({super.key, required this.skillsModel});

  final SkillsModel skillsModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(skillsModel.message ?? "No Skills found."),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlocProvider(
                        create: (context) => SkillsCubit(),
                        child: AddSkillsView(),
                      ),
                ),
              ).then((_) {
                // This gets called when AddSkillView is popped
                BlocProvider.of<SkillsCubit>(context).getSkills();
              });
            },
            child: Text(
              "Go to Add Skills",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
