import 'package:flutter/material.dart';

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  String gender = "Male";
  String drivingLicense = "No";
  String nationality = "Nationality";
  String city = "Choose";
  String area = "Choose";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Personal Info", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Your Name *"),
            Row(
              children: [
                Expanded(child: _buildTextField(" First Name", " ")),
                SizedBox(width: 10),
                Expanded(child: _buildTextField("Last Name", "")),
              ],
            ),
            _buildSectionTitle("Gender *"),
            Row(
              children: [
                _buildRadioOption("Male"),
                _buildRadioOption("Female"),
              ],
            ),
         
            _buildSectionTitle("Mobile Number *"),
            _buildTextField("", ""),
          
           
            _buildSectionTitle("City *"),
            _buildDropdown("Choose", ["Choose", "Cairo", "Alexandria"], (value) {
              setState(() => city = value!);
            }),
          
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                padding: EdgeInsets.symmetric(vertical: 14),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Save Changes", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5),
      child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(String hint, String initialValue) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
      controller: TextEditingController(text: initialValue),
    );
  }

  Widget _buildRadioOption(String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: gender,
          onChanged: (newValue) {
            setState(() => gender = newValue.toString());
          },
        ),
        Text(value),
        SizedBox(width: 20),
      ],
    );
  }

  Widget _buildDrivingLicenseOption(String value) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: drivingLicense,
          onChanged: (newValue) {
            setState(() => drivingLicense = newValue.toString());
          },
        ),
        Text(value),
        SizedBox(width: 20),
      ],
    );
  }

  Widget _buildDropdown(String hint, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: items.first,
      items: items.map((item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }
}
