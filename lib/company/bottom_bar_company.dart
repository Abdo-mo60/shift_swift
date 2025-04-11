import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/company/my_jop/widget/my_jop_view_company.dart';
import 'package:shiftswift/company/my_jop/widget/myjop_company.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/home/presentation/view/home_view.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_floating_action_button.dart';

import 'package:shiftswift/profile/Profile%20All/profile_home.dart';



class CustomBottomCompanyBar extends StatefulWidget {
  const CustomBottomCompanyBar({super.key});

  @override
  State<CustomBottomCompanyBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomCompanyBar> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
   const HomeView() ,
    const ProfileHome(),
   const MyJobViewCompany(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
