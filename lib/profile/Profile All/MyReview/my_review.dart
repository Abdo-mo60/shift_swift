import 'package:flutter/material.dart';

class MyReviewsPage extends StatefulWidget {
  const MyReviewsPage({super.key});

  @override
  State<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Mahmoud Eidhan',
      'date': '10:00 AM, 20 Oct 2021',
      'review':
          'Hade pisan mang urang meuli jacket asalna nu orange ktu hade warna na mengkilap like very good beautifully process',
      'rating': 5,
      'image': 'asstes/d1.png',
    },
    {
      'name': 'Robert Fox',
      'date': '10:00 AM, 20 Oct 2021',
      'review':
          'Hade pisan mang urang meuli jacket asalna nu orange ktu hade warna na mengkilap like very good beautifully process',
      'rating': 3,
      'image': 'asstes/d2.png',
    },
    {
      'name': 'Esther Howard',
      'date': '10:00 AM, 20 Oct 2021',
      'review':
          'Hade pisan mang urang meuli jacket asalna nu orange ktu hade warna na mengkilap like very good beautifully process',
      'rating': 4,
      'image': 'asstes/d3.png',
    },
    {
      'name': 'Ali Ahmed',
      'date': '11:00 AM, 21 Oct 2021',
      'review':
          'Jacket ktu hade warna na mengkilap like very good beautifully process',
      'rating': 2,
      'image': 'asstes/three.png',
    },
    {
      'name': 'Sara Ali',
      'date': '9:00 AM, 22 Oct 2021',
      'review':
          'Beautifully process very good!',
      'rating': 1,
      'image': 'asstes/d1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // فلترة الريفيوز بناءً على الزر المختار
    List<Map<String, dynamic>> filteredReviews = selectedFilter == 'All'
        ? reviews
        : reviews.where((review) => review['rating'].toString() == selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      
        title: const Text(
          "My Reviews",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFilterRows(),
            const SizedBox(height: 20),
            Expanded(
              child: filteredReviews.isNotEmpty
                  ? ListView(
                      children: filteredReviews
                          .map((review) => _buildReviewItem(
                                name: review['name'],
                                date: review['date'],
                                review: review['review'],
                                rating: review['rating'],
                                imageUrl: review['image'],
                              ))
                          .toList(),
                    )
                  : const Center(
                      child: Text(
                        'لا توجد مراجعات لهذا التقييم ⭐',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
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
          children: ['All', '1', '2'].map((filter) {
            return _buildFilterButton(filter);
          }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ['3', '4', '5'].map((filter) {
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
          backgroundColor: isSelected ? const Color(0xFF567DF4) : Colors.white,
          side: BorderSide(
            color: isSelected ? const Color(0xFF567DF4) : Colors.grey.shade300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: const Icon(Icons.star, size: 16, color: Colors.amber),
        label: Text(
          filter,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewItem({
    required String name,
    required String date,
    required String review,
    required int rating,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(imageUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCE8B2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(width: 2),
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}