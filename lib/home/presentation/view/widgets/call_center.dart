import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CallCenterWidget extends StatelessWidget {
  const CallCenterWidget({
    super.key,
    required this.title,
    required this.companyName, required this.imageUrl,
  });
  final String title;
  final String companyName;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(child: SizedBox(
            height: 100,
            width: 100,
            child: CachedNetworkImage(
                imageUrl: imageUrl, 
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset('asstes/images.jpg'), 
              ),
          ),),
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
          if(companyName!='null null')...[
          Text(
            companyName,
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),] 
        ],
      ),
    );
  }
}
