import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/company/Home/post_new_job.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/profile/Cubits/add%20update%20company%20data%20cubit/add_update_company_data_cubit.dart';

class PostJobBar extends StatelessWidget {
  const PostJobBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => AddUpdateCompanyDataCubit(),
                child: PostNewJob(),
              );
            },
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(0),
        color: Color(0xffE9E9E9),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.borderColor, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.post_add, color: AppColors.grey400, size: 16),
                  SizedBox(width: 3),
                  Expanded(
                    child: Text(
                      'Post',
                      style: GoogleFonts.lato(textStyle: AppStyles.regular12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
