import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/model/rating_model.dart';
import '../../../../core/styles.dart';

class RatingCards extends StatelessWidget {
  const RatingCards({super.key, required this.rating});
  final RatingModel rating;
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> ratings = List.generate(
      rating.ratings!.length,
      (index) => {
        "rating": rating.averageScore.toString(),
        "reviews": rating.ratings![index],
      },
    );

    return (rating.ratings!.isEmpty)
        ? Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.grey300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            spacing: 16,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(Icons.star_border, color: Colors.grey);
                }),
              ),
              Text(
                "No Rating For this",
                style: GoogleFonts.lato(textStyle: AppStyles.bold18),
              ),
            ],
          ),
        )
        : SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: ratings.length,
            itemBuilder: (context, index) {
              final rating = ratings[index];

              return IntrinsicWidth(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.grey200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 250, 230),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              rating["rating"].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.star, color: Colors.amber, size: 16),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 250),
                        child: Text(
                          rating["reviews"],
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
  }
}
