import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final String value;
  final String selectedValue;
  final Function(String) onPressed;

  const FilterButton({
    super.key,
    required this.text,
    required this.value,
    required this.selectedValue,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onPressed(value),
        child: Container(
          decoration: BoxDecoration(
            color: selectedValue == value ? AppColors.blue : Colors.transparent,
            border: Border.all(color: AppColors.blue, width: 1.5),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: selectedValue == value ? Colors.white : AppColors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
