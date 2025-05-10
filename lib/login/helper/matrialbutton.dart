import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, });
String text;

  @override
  Widget build(BuildContext context) {
    return  Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
        
          ),
          width:150,
          height: 60,
          child: Center(
            child:Text(text,
            style: TextStyle(color: Colors.white),),
          ),
        );
  }
}