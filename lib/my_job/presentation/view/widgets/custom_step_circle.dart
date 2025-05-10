import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';

class CustomStepCircle extends StatelessWidget {
  const CustomStepCircle({
    super.key,
    required this.index,
    required this.activeStep,
  });
  final int index;
  final int activeStep;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Color(0xff0D9300),
          width: 2,
          style: BorderStyle.solid,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(activeStep == index ? 2 : 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff0D9300),
        ),
        child:
            activeStep > index
                ? Icon(Icons.check, color: AppColors.white, size: 15)
                : null,
      ),
    );
  }
}
