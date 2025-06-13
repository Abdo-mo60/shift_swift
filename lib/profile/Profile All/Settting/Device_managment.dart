import 'package:flutter/material.dart';
import 'package:shiftswift/login/login_home.dart';

class DeviceManagementPage extends StatelessWidget {
  const DeviceManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Device Management',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  TableRow buildRow(String title, Widget content) {
    const titleStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFFEDEEF1),
          // alignment: Alignment.center,
          child: Text(title, style: titleStyle, textAlign: TextAlign.center),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          // alignment: Alignment.center,
          child: content,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const contentTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Table(
              border: TableBorder.all(color: Colors.grey.shade400, width: 1),
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
              },
              children: [
                buildRow(
                  "Device",
                  const Text("Mobile", style: contentTextStyle),
                ),
                buildRow(
                  "Date Logged In",
                  const Text("April 13, 2023", style: contentTextStyle),
                ),
                buildRow(
                  "IP Address",
                  const Text("324.978.243.456 Cairo", style: contentTextStyle),
                ),
                buildRow(
                  "Actions",
                  ElevatedButton(
                    onPressed: () {
                      // هنا بيروح لصفحتك الخاصة
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginHome()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF255B93),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
