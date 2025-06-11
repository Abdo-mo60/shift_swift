import 'package:flutter/material.dart';
import 'package:shiftswift/login/login_home.dart';

class DeviceManagementPage extends StatelessWidget {
  const DeviceManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Device Management',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DeviceCard(
              deviceType: "Mobile",
              ip: "324.978.243.456 Cairo",
              date: "April 13, 2023",
              isCurrentDevice: true,
            ),
            SizedBox(height: 10),
            DeviceCard(
              deviceType: "Mobile",
              ip: "324.978.243.456 Cairo",
              date: "April 13, 2023",
              isCurrentDevice: false,
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final String deviceType;
  final String ip;
  final String date;
  final bool isCurrentDevice;

  const DeviceCard({super.key, 
    required this.deviceType,
    required this.ip,
    required this.date,
    required this.isCurrentDevice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          buildRow("Device", deviceType),
          buildRow("Date Logged In", date),
          buildRow("IP Address", ip),
          buildRow(
            "Actions",
            isCurrentDevice
                ? "This Device"
                : ElevatedButton(
                    onPressed: () {
                      Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => LoginHome()),
);

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text("Sign Out", style: TextStyle(color: Colors.white)),
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String title, dynamic value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          if (value is String)
            Text(value, style: TextStyle(color: Colors.black54))
          else
            value,
        ],
      ),
    );
  }
}
