import 'package:flutter/material.dart';

class AreaSection extends StatelessWidget {
  final String area;
  final Function(String?) onAreaChanged;

  const AreaSection({
    super.key,
    required this.area,
    required this.onAreaChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Area',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 35,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: area.isEmpty ? null : area,
                  onChanged: onAreaChanged,
                  items:
                      <String>[
                        'Choose',
                        'Area 1',
                        'Area 2',
                        'Area 3',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ),
                  dropdownColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  isExpanded: true,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
