import 'package:flutter/material.dart';
import 'package:shiftswift/home/presentation/view/widgets/company_review_item_list_view.dart';
import 'package:shiftswift/home/presentation/view/widgets/company_review_title.dart';
import 'package:shiftswift/home/presentation/view/widgets/custom_container_app_bar.dart';
import 'package:shiftswift/home/presentation/view/widgets/search_items.dart';



class HomeViewCompanyBody extends StatelessWidget {
  const HomeViewCompanyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
            CustomContainerAppBar(),
              SizedBox(height: 60),
              SizedBox(height: 20),
          
            ],
          ),
          Positioned(top: 100, left: 20, right: 20, child: SearchItems()),
        ],
      ),
    );
  }
}
