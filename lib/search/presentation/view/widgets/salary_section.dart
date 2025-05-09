import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class SalarySection extends StatefulWidget {
  final double minSalary;
  final double maxSalary;
  final Function(double) onMinSalaryChanged;
  final Function(double) onMaxSalaryChanged;

  const SalarySection({
    super.key,
    required this.minSalary,
    required this.maxSalary,
    required this.onMinSalaryChanged,
    required this.onMaxSalaryChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SalarySectionState createState() => _SalarySectionState();
}

class _SalarySectionState extends State<SalarySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Salary',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                labelText: 'Min',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  widget.onMinSalaryChanged(double.tryParse(value) ?? 0);
                },
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                labelText: 'Max',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  widget.onMaxSalaryChanged(double.tryParse(value) ?? 0);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
