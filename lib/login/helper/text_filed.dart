import 'package:flutter/material.dart';

Widget customTextField({
  required TextEditingController controller,
  required String hinText,
  bool isScure = false,
   IconData? icon,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      validator: (input) {
        if (controller.text.isEmpty) {
          return '$hinText must not be empty';
        } else {
          return null;
        }
      },
      obscureText: isScure,

      decoration: InputDecoration(
        labelText: hinText,
        border: OutlineInputBorder(),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(icon, color: Colors.black),
        ),
        suffixIcon:(isScure==true)? IconButton(
          icon: Icon(
            (isScure) ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            isScure=!isScure;
          },
        ):null,

        // hintText: hinText,
      ),
    ),
  );
}
