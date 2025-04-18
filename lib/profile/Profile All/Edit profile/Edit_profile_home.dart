import 'package:flutter/material.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Personal.dart';

class  EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        title: Text("Edit Profile",style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   color: Colors.blue.shade800,
          //   padding: EdgeInsets.all(16),
          //   child: Row(
          //     children: [
          //       CircleAvatar(
          //         radius: 30,
          //         backgroundImage: AssetImage('asstes/three.png'), // استبدلها بالصورة الفعلية
          //       ),
          //       SizedBox(width: 12),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             "Abdelrahman mohamed",
          //             style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          //           ),
          //           Text(
          //             "Elmansora, Egypt",
          //             style: TextStyle(fontSize: 14, color: Colors.white70),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
         
         
          ListTile(
            title: Text("Personal Info", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Karim Ali"),
            trailing: OutlinedButton(
              onPressed: () {
                Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => PersonalInfoPage()),
);

              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("View", style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }
}
