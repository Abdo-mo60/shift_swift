import 'package:flutter/material.dart';

class ScreenQuestionsPage extends StatefulWidget {
  const ScreenQuestionsPage({Key? key}) : super(key: key);

  @override
  State<ScreenQuestionsPage> createState() => _ScreenQuestionsPageState();
}

class _ScreenQuestionsPageState extends State<ScreenQuestionsPage> {
  final TextEditingController _questionController = TextEditingController();
  List<String> customQuestions = [];
  Set<String> selectedSuggested = {};

  InputDecoration customInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  final List<String> suggestedQuestions = [
    'Do You Have A Car?',
    'Talk About Yourself',
    'Your Gender?',
    'Why Do You Want This Job?',
  ];

  void addCustomQuestion() {
    final text = _questionController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        customQuestions.add(text);
        _questionController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Contact Information'),
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Screen Questions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            TextField(
              controller: _questionController,
              decoration: customInputDecoration('Add a Question'),
            ),
            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: addCustomQuestion,
              icon: const Icon(Icons.add),
              label: const Text('Add Question'),
            ),

            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Suggested Questions', style: TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: suggestedQuestions.map((q) {
                final isSelected = selectedSuggested.contains(q);
                return ChoiceChip(
                  label: Text(q),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      if (isSelected) {
                        selectedSuggested.remove(q);
                      } else {
                        selectedSuggested.add(q);
                      }
                    });
                  },
                  selectedColor: Colors.blue,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Your Questions', style: TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 10),
            ...customQuestions.map((q) => ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: Text(q),
                )),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                // Post logic
              },
              child: const Text('Post'),
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
