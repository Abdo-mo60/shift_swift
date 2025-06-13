import 'package:flutter/material.dart';
import 'package:shiftswift/core/app_colors.dart';

class HelpCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Help Center" , style: TextStyle(color: AppColors.blue),),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان "FAQ"
            Text(
              "FAQ",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // قائمة الأسئلة الشائعة
            Expanded(
              child: ListView(
                children: [
                  _buildExpansionTile(
                    "When Is It Starting?",
                    "Our program begins on 24 March, 2022 at 10:00AM IST.",
                  ),
                  SizedBox(height: 25,),
                  _buildExpansionTile(
                    "What Is The Location?",
                    "Location is: 615 S Broadway, Los Angeles, CA 90014, United States.",
                  ),
                  SizedBox(height: 25,),
                  _buildExpansionTile(
                    "What Do We Have To Carry Along With Us?",
                    "Here's a quick list of carry-alongs:\n"
                        "1. A book bag\n"
                        "2. Any art supplies that you can find at home\n"
                        "3. A rough notepad\n"
                        "4. A tablet or laptop of your choice",
                  ),
                  SizedBox(height: 25,),
                  _buildExpansionTile(
                    "Do We Have To Carry A Ticket?",
                    "No, only carry along the email you receive after you book your slot.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة لإنشاء عنصر قائمة منسدلة
  Widget _buildExpansionTile(String title, String content) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(content, style: TextStyle(color: Colors.grey[700], fontSize: 20)),
          ),
        ],
      ),
    );
  }
}