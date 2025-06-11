import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/bottom_navigation_bar.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/my_job/presentation/view/widgets/custom_my_job_button.dart';

class ApplicantIntialView extends StatelessWidget {
  const ApplicantIntialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset('asstes/saved.png'),
                    Text(
                      'Go to jobs to See Applicants',
                      style: GoogleFonts.lato(textStyle: AppStyles.bold24),
                    ),
                    // Text(
                    //   'Your notification will appear here once you\'vereceived them. ',
                    //   style: GoogleFonts.lato(textStyle: AppStyles.regular14),
                    //   textAlign: TextAlign.center,
                    // ),
                    SizedBox(height: 30),
                    CustomMyJobButton(
                      text: 'Home',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CustomBottomNavigationBar();
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