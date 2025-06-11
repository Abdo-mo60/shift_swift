import 'package:flutter/material.dart';
import 'package:shiftswift/profile/Profile All/Settting/manage2.dart' ;



class TwoFactorAuthPage extends StatelessWidget {
  const TwoFactorAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Two-Factor Authentication (2FA)"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Authenticator App",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text("Use codes from an authenticator app to sign in",
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // التنقل إلى الصفحة الثانية عند الضغط على الزر
               
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.blue),
                  SizedBox(width: 5),
                  Text("+ Add", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Text Messages",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text("(+33) 7 75 55 87 24", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.blue),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.blue),
                  SizedBox(width: 5),
                  Text("Change", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => AddAuthenticatorKeyPage()),
);

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Disable", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
