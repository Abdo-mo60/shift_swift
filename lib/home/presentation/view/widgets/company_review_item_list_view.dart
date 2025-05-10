import 'package:flutter/material.dart';
import 'company_review_item.dart';

class CompanyReviewItemListView extends StatelessWidget {
  const CompanyReviewItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 90,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CompanyReviewItem(),
            );
          },
        ),
      ),
    );
  }
}
