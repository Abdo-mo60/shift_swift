import 'package:flutter/material.dart';
import 'package:shiftswift/login/login_home.dart';

class DeleteAccountPage extends StatefulWidget {
  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  String selectedReason = "Other";
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Delete Account', style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        child: Column(
          children: [
            Text("If you need to delete an account, provide a reason"),
            Expanded(
              child: ListView(
                children: [
                  RadioListTile(
                    title: Text("No longer using the service/platform"),
                    value: "No longer using",
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Found a better alternative"),
                    value: "found a better",
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Privacy concerns"),
                    value: "Privacy concerns",
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Too many emails'/notification"),
                    value: "Too many",
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Personal reasons"),
                    value: "Personal",
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value.toString();
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text("Difficulty navigating the platform"),
                    value: "Difficulty",
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value.toString();
                      });
                    },
                  ),

                  RadioListTile(
                    title: Text("Other"),
                    value: "Other",
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value.toString();
                      });
                    },
                  ),
                  if (selectedReason == "Other")
                    TextField(
                      controller: messageController,
                      decoration: InputDecoration(labelText: "Write your message here"),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: ElevatedButton(
                onPressed: () {
                  // حذف الحساب أو تنفيذ العملية المطلوبة
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginHome()),
                  );

                },
              
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Delete Account",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
