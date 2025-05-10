import 'package:flutter/material.dart';
import 'package:shiftswift/company/my_jop/widget/details.dart';
import 'package:shiftswift/company/my_jop/widget/my_jop_shortlist.dart';



class RecevidViewCompany extends StatelessWidget {
  const RecevidViewCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F0),
      body: 
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Karim Ali", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text("Security officer", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                       'asstes/d1.png' ,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                const Divider(height: 25),
                SizedBox( height: 15,),
                const Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 20),
                    SizedBox(width: 8),
                    Text("Cairo"),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.access_time_outlined, size: 20),
                    SizedBox(width: 8),
                    Text("Full Time"),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 20),
                    SizedBox(width: 8),
                    Text("6000 EGP/Month"),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: const [
                          Text("4"),
                          SizedBox(width: 4),
                          Icon(Icons.star, color: Colors.amber, size: 18),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "(51,365 Reviews)",
                      style: TextStyle(color: Colors.blue.shade700),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          side: const BorderSide(color: Colors.blue),
                        ),
                        child: const Text("Move To Short List", style: TextStyle(
                          fontSize: 13
                        ),),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CandidateDetailsPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text("View", style: TextStyle(
                          fontSize: 15
                        ),),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      
    );
  }
}



