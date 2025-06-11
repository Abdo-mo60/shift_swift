import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/core/styles.dart';

class AcceptRejectButton extends StatelessWidget {
  const AcceptRejectButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
  });
  final void Function()? onTap;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 180,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // isIcon ? Icon(Icons.pages, color: AppColors.blue) : SizedBox(),
            // SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.lato(
                textStyle: AppStyles.medium20.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
