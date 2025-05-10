import 'package:flutter/material.dart';
import 'package:shiftswift/company/Home/continoPost.dart';


class PostNewJob extends StatefulWidget {
  const PostNewJob({Key? key}) : super(key: key);

  @override
  State<PostNewJob> createState() => _PostNewJobPageState();
}

class _PostNewJobPageState extends State<PostNewJob> {
  String selectedJobType = '';
  String selectedLocation = '';

  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> jobTypes = ['Full Time', 'Part Time', 'Freelance'];
    List<String> jobLocations = ['On Site', 'Remotely', 'Hybrid'];
    List<String> cities = ['Cairo', 'Alex', 'Suez'];
    List<String> salaryTypes = ['Per month', 'Per Hour', 'Contract'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Contact Information'),
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Post New Job', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            TextField(
              decoration: customInputDecoration('Job Title *'),
            ),

            const SizedBox(height: 12),
            const Text('Job Type *'),
            Wrap(
              spacing: 8,
              children: jobTypes.map((type) {
                final isSelected = selectedJobType == type;
                return ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedJobType = type;
                    });
                  },
                  selectedColor: Colors.blue,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
            ),

            const SizedBox(height: 12),
            const Text('Job Location *'),
            Wrap(
              spacing: 8,
              children: jobLocations.map((loc) {
                final isSelected = selectedLocation == loc;
                return ChoiceChip(
                  label: Text(loc),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedLocation = loc;
                    });
                  },
                  selectedColor: Colors.blue,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
            ),

            const SizedBox(height: 12),
            SizedBox(
              height: 45,
              child: DropdownButtonFormField<String>(
                decoration: customInputDecoration('City'),
                items: cities
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (_) {},
              ),
            ),

            const SizedBox(height: 12),
            TextField(
              decoration: customInputDecoration('Salary'),
            ),

            const SizedBox(height: 12),
            SizedBox(
              height: 45,
              child: DropdownButtonFormField<String>(
                decoration: customInputDecoration('Salary Type'),
                items: salaryTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (_) {},
              ),
            ),

            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: customInputDecoration('Job Description *'),
            ),

            const SizedBox(height: 12),
            TextField(
              maxLines: 3,
              decoration: customInputDecoration('Job Requirements *'),
            ),

            const SizedBox(height: 12),
            TextField(
              decoration: customInputDecoration('Key Words'),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScreenQuestionsPage()),
                );
              },
              child: const Text('Continue'),
            ),

            TextButton(
              onPressed: () {
                // Save and Post Later logic
              },
              child: const Text('Save And Post Later'),
            ),
          ],
        ),
      ),
    );
  }
}
