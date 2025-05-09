import 'package:flutter/material.dart';

import 'filter_button.dart';

class SortBySection extends StatelessWidget {
  final String sortBy;
  final Function(String) onSortChanged;

  const SortBySection({
    super.key,
    required this.sortBy,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort by',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            FilterButton(
              text: 'Latest',
              value: 'Latest',
              selectedValue: sortBy,
              onPressed: (value) => onSortChanged(value),
            ),
            SizedBox(width: 8),
            FilterButton(
              text: 'Oldest',
              value: 'Oldest',
              selectedValue: sortBy,
              onPressed: (value) => onSortChanged(value),
            ),
            SizedBox(width: 8),
            FilterButton(
              text: 'Full Time',
              value: 'Full Time',
              selectedValue: sortBy,
              onPressed: (value) => onSortChanged(value),
            ),
          ],
        ),
      ],
    );
  }
}
