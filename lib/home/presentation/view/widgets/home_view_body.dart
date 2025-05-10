import 'package:flutter/material.dart';
import 'package:shiftswift/home/presentation/view/widgets/home_view_item_column.dart';

import 'custom_container_app_bar.dart';

import 'search_items.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              CustomContainerAppBar(),
              SizedBox(height: 60),
              HomeViewItemColumn(),
            ],
          ),
          Positioned(top: 100, left: 20, right: 20, child: SearchItems()),
        ],
      ),
    );
  }
}
