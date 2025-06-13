import 'package:flutter/material.dart';

class AddAuthenticatorKeyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Two-Factor Authentication (2FA)"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 60),
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please Add This Key to your Authenticator App",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gd546-Lk...-Kd94v",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.copy, color: Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
