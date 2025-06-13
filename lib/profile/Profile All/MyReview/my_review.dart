import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/profile/Cubits/reviews%20cubit/reviews_cubit.dart';
import 'package:shiftswift/profile/Models/reviews_model.dart';

class MyReviewsPage extends StatefulWidget {
  const MyReviewsPage({super.key, required this.companyId});
  final String companyId;
  @override
  State<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  String selectedFilter = 'All';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ReviewsCubit>(
      context,
    ).getReviews(companyId: widget.companyId);
  }
  // final List<Map<String, dynamic>> reviews = [
  //   {
  //     'name': 'Mahmoud Eidhan',
  //     'date': '10:00 AM, 20 Oct 2021',
  //     'review':
  //         'Hade pisan mang urang meuli jacket asalna nu orange ktu hade warna na mengkilap like very good beautifully process',
  //     'rating': 5,
  //     'image': 'asstes/d1.png',
  //   },
  //   {
  //     'name': 'Robert Fox',
  //     'date': '10:00 AM, 20 Oct 2021',
  //     'review':
  //         'Hade pisan mang urang meuli jacket asalna nu orange ktu hade warna na mengkilap like very good beautifully process',
  //     'rating': 3,
  //     'image': 'asstes/d2.png',
  //   },
  //   {
  //     'name': 'Esther Howard',
  //     'date': '10:00 AM, 20 Oct 2021',
  //     'review':
  //         'Hade pisan mang urang meuli jacket asalna nu orange ktu hade warna na mengkilap like very good beautifully process',
  //     'rating': 4,
  //     'image': 'asstes/d3.png',
  //   },
  //   {
  //     'name': 'Ali Ahmed',
  //     'date': '11:00 AM, 21 Oct 2021',
  //     'review':
  //         'Jacket ktu hade warna na mengkilap like very good beautifully process',
  //     'rating': 2,
  //     'image': 'asstes/three.png',
  //   },
  //   {
  //     'name': 'Sara Ali',
  //     'date': '9:00 AM, 22 Oct 2021',
  //     'review':
  //         'Beautifully process very good!',
  //     'rating': 1,
  //     'image': 'asstes/d1.png',
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left_outlined),
          color: Colors.grey,
          iconSize: 40,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Reviews",
          style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFilterRows(),
            const SizedBox(height: 20),
            BlocBuilder<ReviewsCubit, ReviewsState>(
              builder: (context, state) {
                if (state is ReviewsSuccess) {
                  List<ReviewsModel> reviewsList = state.reviewsList;
                  List<ReviewsModel> filteredReviews =
                      selectedFilter == 'All'
                          ? reviewsList
                          : reviewsList
                              .where(
                                (review) =>
                                    review.score.toInt().toString() ==
                                    selectedFilter,
                              )
                              .toList();
                  return Expanded(
                    child:
                        filteredReviews.isNotEmpty
                            ? ListView(
                              children:
                                  filteredReviews
                                      .map(
                                        (review) => _buildReviewItem(
                                          name: review.ratedByUserNAme,
                                          date: review.createdAt,
                                          review: review.comment,
                                          rating: review.score,
                                          imageUrl: review.ratedByImageUrl,
                                        ),
                                      )
                                      .toList(),
                            )
                            : const Center(
                              child: Text(
                                'No reviwes found⭐',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                  );
                } else if (state is ReviewsFailure) {
                  return Text(state.message);
                } else if (state is NoReviews) {
                  return Expanded(
                    child: const Center(
                      child: Text(
                        'No reviwes found⭐',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRows() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              ['All', '1', '2'].map((filter) {
                return _buildFilterButton(filter);
              }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              ['3', '4', '5'].map((filter) {
                return _buildFilterButton(filter);
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildFilterButton(String filter) {
    final bool isSelected = selectedFilter == filter;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton.icon(
        onPressed: () {
          setState(() {
            selectedFilter = filter;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.blue : Colors.white,
          side: BorderSide(color: AppColors.blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: const Icon(Icons.star, size: 16, color: Colors.amber),
        label: Text(
          filter,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildReviewItem({
    required String name,
    required String date,
    required String review,
    required double rating,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage:(imageUrl=='')?AssetImage('asstes/profile.png'): NetworkImage(
                  imageUrl,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightyellow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rating.toInt().toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.star, color: Colors.amber, size: 22),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
