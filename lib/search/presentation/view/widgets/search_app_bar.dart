import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackButtonPressed;

  const SearchAppBar({super.key, required this.onBackButtonPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new, color: AppColors.borderColor),
        onPressed: onBackButtonPressed,
      ),
      title: Text("Search", style: TextStyle(color: AppColors.blue)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
