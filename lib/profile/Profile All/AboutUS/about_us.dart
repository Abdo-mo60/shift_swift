import 'package:flutter/material.dart';
import 'package:shiftswift/core/app_colors.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("About Us", style: TextStyle(color: AppColors.blue),),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildExpansionTile(
              "Who We Are ?",
              "We are a leading company in job recruitment, helping job seekers find the best opportunities.",
            ),
            SizedBox(height: 25,),
            _buildExpansionTile(
              "Looking For A Job ?",
              "If you are searching for a new career opportunity, you can search open vacancies and jobs. You can also be alerted of new jobs by email.",
            ),
             SizedBox(height: 25,),
            _buildExpansionTile(
              "Are You A Recruiter Or Employer ?",
              "If you are currently hiring and would like to advertise your jobs, please sign up for an employer account and post your jobs right away.",
            ),
          ],
        ),
      ),
    );
  }

  // دالة لإنشاء عنصر قائمة منسدلة
  Widget _buildExpansionTile(String title, String content) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 20)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(content, style: TextStyle(color: Colors.grey[700],
            fontSize: 20)),
          ),
        ],
      ),
    );
  }
}