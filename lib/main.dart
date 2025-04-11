import 'package:flutter/material.dart';
import 'package:shiftswift/bottom_navigation_bar.dart' show CustomBottomNavigationBar;
import 'package:shiftswift/company/bottom_bar_company.dart';
import 'package:shiftswift/home/presentation/view/widgets/home_view_body.dart';



import 'package:shiftswift/core/app_colors.dart';


void main() {
  runApp(const Shiftswift());
}

class Shiftswift extends StatelessWidget {
  const Shiftswift({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomBottomCompanyBar(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
      ),
    );
  }
}
