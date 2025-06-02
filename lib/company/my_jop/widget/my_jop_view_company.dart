import 'package:flutter/material.dart';
import 'package:shiftswift/company/my_jop/widget/my_gop_received.dart';
import 'package:shiftswift/company/my_jop/widget/my_jop_shortlist.dart';

import 'package:shiftswift/my_job/model/tap_bar_model.dart';
import 'package:shiftswift/my_job/presentation/view/applied_view.dart';
import 'package:shiftswift/my_job/presentation/view/last_work_view.dart';

import 'package:shiftswift/my_job/presentation/view/widgets/custom_tap_bar_button.dart';
import '../../../../core/app_colors.dart';


class MyJobViewCompanyBody extends StatefulWidget {
  const MyJobViewCompanyBody({super.key});

  @override
  State<MyJobViewCompanyBody> createState() => _MyJobViewBodyState();
}

int selectedItem = 0;

class _MyJobViewBodyState extends State<MyJobViewCompanyBody> {
  @override
  Widget build(BuildContext context) {
    List<TapBarModel> tapBar = [
      TapBarModel(text: 'Received', widget:  RecevidViewCompany()),
      
      
      TapBarModel(text: 'Short List', widget: ShortListPage()),
    ];
    return Column(
      children: [
        Container(
          color: AppColors.blue,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            spacing: 10,
            children: List.generate(tapBar.length, (index) {
              return Expanded(
                child: CustomTapBarButton(
                  text: tapBar[index].text,
                  isSelected: index == selectedItem,
                  onPressed: () {
                    selectedItem = index;
                    setState(() {});
                  },
                ),
              );
            }),
          ),
        ),
        Expanded(child: tapBar[selectedItem].widget),
      ],
    );
  }
}
