import 'package:flutter/material.dart';
import 'package:shiftswift/core/app_colors.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.title, required this.page});
  final String title;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return ListTile(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Edit", style: TextStyle(color: AppColors.blue)),
            ),
          );
  }
}