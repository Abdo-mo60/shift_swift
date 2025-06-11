import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/company/Home/post_new_job.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/my_job/presentation/view/widgets/custom_my_job_button.dart';
import 'package:shiftswift/profile/Cubits/add%20update%20company%20data%20cubit/add_update_company_data_cubit.dart';

class NoJobsView extends StatelessWidget {
  const NoJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 120,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('asstes/saved.png'),
                    Text(
                      //'${state.jobPostList[0].message}',
                      'No Jobs Found...Go Post a Job',
                      style: GoogleFonts.lato(textStyle: AppStyles.bold24),
                    ),
                    Text(
                      'Your Jobs will appear here once you Post a Job ',
                      style: GoogleFonts.lato(textStyle: AppStyles.regular14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    CustomMyJobButton(
                      text: 'Post Job',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider(
                                create:
                                    (context) => AddUpdateCompanyDataCubit(),
                                child: PostNewJob(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
  }
}