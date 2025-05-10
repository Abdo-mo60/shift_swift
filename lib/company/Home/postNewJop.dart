import 'package:flutter/material.dart';
import 'package:shiftswift/company/Home/continoPost.dart';


class PostNewJob extends StatefulWidget {
  const PostNewJob({Key? key}) : super(key: key);

  @override
  State<PostNewJob> createState() => _PostNewJobPageState();
}

class _PostNewJobPageState extends State<PostNewJob> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedJobType = '';
  String selectedLocation = '';

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController jobDescriptionController = TextEditingController();
  final TextEditingController jobRequirementsController = TextEditingController();
  final TextEditingController keywordsController = TextEditingController();

  String? selectedCity;
  String? selectedSalaryType;

  InputDecoration customInputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  Widget buildLabeledField(String label, Widget field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        field,
      ],
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
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Post New Job', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              buildLabeledField(
                'Job Title ',
                TextFormField(
                  controller: jobTitleController,
                  decoration: customInputDecoration(),
                  validator: (value) => (value == null || value.isEmpty) ? '* ' : null,
                ),
              ),

              const SizedBox(height: 16),
              const Text('Job Type'),
              const SizedBox(height: 8),
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
              if (selectedJobType.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(' ', style: TextStyle(color: Colors.red)),
                ),

              const SizedBox(height: 16),
              const Text('Job Location'),
              const SizedBox(height: 8),
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
              if (selectedLocation.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('', style: TextStyle(color: Colors.red)),
                ),

              const SizedBox(height: 16),
              buildLabeledField(
                'City',
                DropdownButtonFormField<String>(
                  decoration: customInputDecoration(),
                  items: cities.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  value: selectedCity,
                  onChanged: (value) {
                    setState(() => selectedCity = value);
                  },
                  validator: (value) => value == null ? '*' : null,
                ),
              ),

              const SizedBox(height: 16),
               buildLabeledField(
                'Salary',
                DropdownButtonFormField<String>(
                  decoration: customInputDecoration(),
                  items: cities.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  value: selectedCity,
                  onChanged: (value) {
                    setState(() => selectedCity = value);
                  },
                  validator: (value) => value == null ? '*' : null,
                ),
              ),

              const SizedBox(height: 16),
              buildLabeledField(
                'Salary Type',
                DropdownButtonFormField<String>(
                  decoration: customInputDecoration(),
                  items: salaryTypes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  value: selectedSalaryType,
                  onChanged: (value) {
                    setState(() => selectedSalaryType = value);
                  },
                ),
              ),

              const SizedBox(height: 16),
              buildLabeledField(
                'Job Description ',
                TextFormField(
                  controller: jobDescriptionController,
                  maxLines: 3,
                  decoration: customInputDecoration(),
                  validator: (value) => (value == null || value.isEmpty) ? ' *  ' : null,
                ),
              ),

              const SizedBox(height: 16),
              buildLabeledField(
                'Job Requirements ',
                TextFormField(
                  controller: jobRequirementsController,
                  maxLines: 3,
                  decoration: customInputDecoration(),
                  validator: (value) => (value == null || value.isEmpty) ? ' * ' : null,
                ),
              ),

              const SizedBox(height: 16),
              buildLabeledField(
                'Key Words',
                DropdownButtonFormField<String>(
                  decoration: customInputDecoration(),
                  items: cities.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  value: selectedCity,
                  onChanged: (value) {
                    setState(() => selectedCity = value);
                  },
                  validator: (value) => value == null ? '*' : null,
                ),
              ),


              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                  final isJobTypeSelected = selectedJobType.isNotEmpty;
                  final isLocationSelected = selectedLocation.isNotEmpty;

                  setState(() {}); // لإظهار رسائل الخطأ تحت الـ ChoiceChips

                  if (isValid && isJobTypeSelected && isLocationSelected) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ScreenQuestionsPage()),
                    );
                  }
                },
                child: const Text('Continue'),
              ),

              TextButton(
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                  final isJobTypeSelected = selectedJobType.isNotEmpty;
                  final isLocationSelected = selectedLocation.isNotEmpty;

                  setState(() {});

                  if (isValid && isJobTypeSelected && isLocationSelected) {
                    // Save logic here
                  }
                },
                child: const Text('Save And Post Later'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
