import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class HiringTeamCard extends StatelessWidget {
  const HiringTeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("View Hiring Team", style: TextStyle(fontSize: 25)),
          SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("asstes/Frame 953.png"),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "karim Hassan",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 250),
                    child: Text(
                      "Responding to customer questions and providing the required information\nResponding to customer",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
