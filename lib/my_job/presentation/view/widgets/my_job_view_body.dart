import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../model/tap_bar_model.dart';
import '../applied_view.dart';
import '../no_saved_view.dart';
import '../saved_view.dart';
import 'custom_tap_bar_button.dart';

class MyJobViewBody extends StatefulWidget {
  const MyJobViewBody({super.key});

  @override
  State<MyJobViewBody> createState() => _MyJobViewBodyState();
}

int selectedItem = 0;

class _MyJobViewBodyState extends State<MyJobViewBody> {
  @override
  Widget build(BuildContext context) {
    List<TapBarModel> tapBar = [
      TapBarModel(text: 'Saved', widget: SavedView()),
      TapBarModel(text: 'Applied', widget: AppliedView()),
      TapBarModel(text: 'last work', widget: NoSavedView()),
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
