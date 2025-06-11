import 'package:flutter/material.dart';

class CallCenterWidget extends StatelessWidget {
  const CallCenterWidget({
    super.key,
    required this.title,
    required this.companyName,
    this.imageUrl,
  });
  final String title;
  final String companyName;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child:
                imageUrl == null
                    ? Image.asset('asstes/image 4.png')
                    : Image.network(imageUrl!,width:80,),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
