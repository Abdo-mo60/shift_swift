import 'package:flutter/material.dart';

class ViewProfileLastWork extends StatelessWidget {
  const ViewProfileLastWork({super.key});

  @override
  Widget build(BuildContext context) {
    //last work object from get last work cubit and probably init stat
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Icon(Icons.reply), Text('last work')]),
        Row(
          children: [
            Image.asset('asstes/pre.png', width: 40, height: 40),
            SizedBox(width: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medical Assistant',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text('Bank of America'),
                Text('February 28, 2018 - present'),
                Row(
                  children: List.generate(
                    5,
                    (index) =>
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
