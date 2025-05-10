import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
