import 'package:flutter/material.dart';
import 'package:shiftswift/core/app_colors.dart';

class ViewApplicantUserNameImage extends StatelessWidget {
  const ViewApplicantUserNameImage({super.key, required this.userName, required this.imageUrl});
  final String userName;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      color: AppColors.blue,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Spacer(flex: 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CircleAvatar(
                  radius: 35,
                  
                  backgroundImage:(imageUrl=='')? AssetImage('asstes/profile.png'): NetworkImage(imageUrl),
                ),
              ),
              Text(
                userName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
