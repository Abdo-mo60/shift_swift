import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});
  final TextEditingController controller ;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

bool _obscureText = true;

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: TextFormField(
          validator: (input) {
          if (widget.controller.text.isEmpty) {
            return 'Password must not be empty';
          } else {
            return null;
          }
        },
        controller:widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.lock_outline, color: Colors.black),
          ),
          labelText: 'Password',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}
