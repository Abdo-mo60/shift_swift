import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClose;
  final VoidCallback onMorePressed;

  const CustomAppBar({
    required this.onClose,
    required this.onMorePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.main,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close, color: Colors.grey),
        onPressed: onClose,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.grey),
          onPressed: onMorePressed,
        ),
      ],
     );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
