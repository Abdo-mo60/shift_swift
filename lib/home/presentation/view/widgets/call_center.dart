import 'package:flutter/material.dart';

class CallCenterWidget extends StatelessWidget {
  const CallCenterWidget({
    super.key,
    required this.title,
    required this.companyName,
  });
  final String title;
  final String companyName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(child: Image.asset('asstes/image 4.png')),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 5),
              Icon(Icons.verified, color: Colors.blue, size: 20),
            ],
          ),
          SizedBox(height: 8),
          Text(
            companyName,
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
