import 'package:flutter/material.dart';

class CandidateDetailsPage extends StatelessWidget {
  const CandidateDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Candidate Details"), backgroundColor: Colors.blue),
      body: const Center(child: Text("تفاصيل المرشح هنا")),
    );
  }
}
