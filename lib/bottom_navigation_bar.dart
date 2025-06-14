import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/company/Home/home_view_combany_body.dart';
import 'package:shiftswift/company/Home/post_new_job.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/home/presentation/view/home_view.dart';
import 'package:shiftswift/profile/Cubits/add%20update%20company%20data%20cubit/add_update_company_data_cubit.dart';
import 'package:shiftswift/profile/Cubits/picture%20cubit/picture_cubit.dart';
import 'package:shiftswift/profile/Profile%20All/profile_home.dart';

import 'home/presentation/view/widgets/custom_floating_action_button.dart';
import 'my_job/presentation/view/my_job_view.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    this.initialIndex = 0,
    this.jobId,
    this.jobmodel,
  });
  final int initialIndex;
  final String? jobId;
  final CompanyJobPostModel? jobmodel;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;

  late List<Widget> _pages;

  //  static final List<Widget> _pages = [
  //     const HomeView(),
  //     const ProfileHome(),
  //    const MyJobView(),
  //   ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
    if (accType == 'Member') {
      _pages = [
        const HomeView(),
        BlocProvider(create: (context) => PictureCubit(), child: ProfileHome()),
        const MyJobView(),
      ];
    } else {
      _pages = [
        const HomeViewCompanyBody(),
        BlocProvider(
          create: (context) => PictureCubit(),
          child: const ProfileHome(),
        ),
        BlocProvider(
          create: (context) => AddUpdateCompanyDataCubit(),
          child: PostNewJob(),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        isSelected: _selectedIndex == 2,
        onTap: () {
          _onItemTapped(2);
        },
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: AppColors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.person, "Profile", 1),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected)
            Icon(icon, color: AppColors.blue)
          else
            Icon(icon, color: AppColors.black),
          Text(
            label,
            style: GoogleFonts.lato(
              textStyle: AppStyles.medium14.copyWith(
                color: isSelected ? AppColors.blue : null,
              ),
            ),
          ),
          SizedBox(height: 8),
          if (isSelected)
            Container(
              height: 12,
              width: 25,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.vertical(top: Radius.circular(100)),
              ),
            ),
        ],
      ),
    );
  }
}
