import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class JobDescriptionCard extends StatelessWidget {
  const JobDescriptionCard({
    super.key,
    required this.description,
    required this.location,
    required this.jobType,
    required this.salary,
    required this.salaryType,
  });
  final String description;
  final String location;
  final String jobType;
  final String salary;
  final String salaryType;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: AppColors.grey200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0.5,
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Job Description",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ..._buildJobResponsibilities(),
              Divider(),
              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _jobDetail(Icons.location_on, "Location", location),
                      SizedBox(height: 12),
                      _jobDetail(Icons.person, "Gender", "Male/Female"),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _jobDetail(Icons.access_time, "Job Type", jobType),
                      SizedBox(height: 12),
                      _jobDetail(
                        Icons.money,
                        "Salary",
                        "$salary EGP/$salaryType",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildJobResponsibilities() {
    List<String> responsibilities = [description];
    return responsibilities
        .map(
          (text) => Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Icon(Icons.circle, size: 8, color: AppColors.grey400),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _jobDetail(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.blue),
        SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
