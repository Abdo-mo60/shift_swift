import 'package:flutter/material.dart';
import 'package:shiftswift/home/presentation/view/widgets/search_job_widget.dart';
import '../../../../core/app_colors.dart';
import '../../../../search/presentation/view/search_view.dart';

class SearchItems extends StatelessWidget {
  const SearchItems({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SearchView();
            },
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(0),
        color: Color(0xffE9E9E9),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.borderColor, width: 0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              SearchJobWidget(
                text: 'Search Job',
                prefixIcon: Icons.search_outlined,
                suffixIcon: Icons.tune,
              ),
              Divider(color: Color(0xffCFCFCF), height: 10),
              SearchJobWidget(
                text: 'Type your location',
                prefixIcon: Icons.location_on_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
