import 'package:flutter/material.dart';
import 'package:shiftswift/core/app_colors.dart';

class CustomPostJobFields extends StatelessWidget {
  CustomPostJobFields({
    super.key,
    required this.label,
    this.controller,
    this.inputType,
    this.maxLines,
    this.widget,
    this.focusNode,
  });
  final String label;
  TextEditingController? controller;
  int? maxLines;
  TextInputType? inputType;
  Widget? widget;
  FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        widget ??
            TextFormField(
              focusNode: focusNode,
              controller: controller,
              validator: (input) {
                if (controller!.text.isEmpty) {
                  return '$label Required';
                } else {
                  return null;
                }
              },
              keyboardType: inputType ?? TextInputType.text,
              maxLines: maxLines ?? 1,
              decoration: customInputDecoration(),
            ),
            
      ],
    );
  }
}
class BuildLabeledField extends StatefulWidget {
   BuildLabeledField({super.key, required this.label, required this.itemsList});
final String label;
final List<String> itemsList;
String ?selected;

  @override
  State<BuildLabeledField> createState() => _BuildLabeledFieldState();
}

class _BuildLabeledFieldState extends State<BuildLabeledField> {
  @override
  Widget build(BuildContext context) {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Text(widget.label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
         DropdownButtonFormField<String>(
                        decoration: customInputDecoration(),
                        items:
                            widget.itemsList
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        value: widget.selected,
                        onChanged: (value) {
                          setState(() => widget.selected = value);
                        },
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return '${widget.label} Reuired';
                          }
                          return null;
                        },
                      ),
      ],
    );
  }
}

InputDecoration customInputDecoration() {
  return InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.blue, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  );
}



class JobOptionsSelection extends StatefulWidget {
  const JobOptionsSelection({
    super.key,
    required this.jobOptionsList,
    required this.onOptionSelected,
    this.initialValue,
  });

  final List<String> jobOptionsList;
  final ValueChanged<String> onOptionSelected;
  final String? initialValue;

  @override
  State<JobOptionsSelection> createState() => _JobOptionsSelectionState();
}

class _JobOptionsSelectionState extends State<JobOptionsSelection> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    // Initialize selectedOption from the parent value
    selectedOption = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children:
          widget.jobOptionsList.map((type) {
            final isSelected = selectedOption == type;
            return ChoiceChip(
              label: Text(type),
              selected: isSelected,
              selectedColor: AppColors.blue,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
              backgroundColor: Colors.grey[200],
              onSelected: (_) {
                setState(() {
                  selectedOption = type;
                });
                widget.onOptionSelected(
                  type,
                ); // Notify parent with the updated value
              },
            );
          }).toList(),
    );
  }
}
// class CustomDropdownField extends StatefulWidget {
//   const CustomDropdownField({
//     super.key,
//     required this.list,
//     required this.onChanged,
//     this.initialValue,
//   });

//   final List<String> list;
//   final ValueChanged<String?> onChanged;
//   final String? initialValue;

//   @override
//   State<CustomDropdownField> createState() => _CustomDropdownFieldState();
// }

// class _CustomDropdownFieldState extends State<CustomDropdownField> {
//   String? selected;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the selected value from the parent
//     selected = widget.initialValue;
//   }

//   @override
//   Widget build(BuildContext context) {
//      // Ensure selected value exists once in the list
//     final validItems = widget.list.toSet().toList();
//    final safeValue = (widget.initialValue != null && validItems.contains(widget.initialValue))
//       ? widget.initialValue
//       : null;
//     return DropdownButtonFormField<String>(
//       menuMaxHeight: 250,
//       decoration: customInputDecoration(),
//       items:
//           widget.list
//               .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//               .toList(),
//       value: safeValue,
//       onChanged: (value) {
//         setState(() => selected = value);
//         widget.onChanged(value); // Notify parent with the updated value
//       },
//       validator: (value) => (value == null|| value.isEmpty) ? 'Required' : null,
//     );
//   }
// }