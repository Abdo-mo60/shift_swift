import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_colors.dart';
import '../../../../home/presentation/manager/home_view_cubit.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterPressed;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        context.read<HomeViewCubit>().search(value);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: AppColors.borderColor),
        suffixIcon: GestureDetector(
          onTap: onFilterPressed,
          child: Icon(Icons.tune, color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
