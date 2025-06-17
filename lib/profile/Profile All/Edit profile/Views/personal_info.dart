import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/profile/Cubits/add%20update%20person%20info/add_update_person_info_cubit.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => PersonalInfoPagestate();
}

class PersonalInfoPagestate extends State<PersonalInfoPage> {
  String gender = '';
  String? nationality;
  String? city;
  String? area;
  String? level;

  final firstNameController = TextEditingController();
  final lastNameControlloer = TextEditingController();
  final alternativemobileNumberController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final universityNameController = TextEditingController();
  final facultyController = TextEditingController();
  final birthDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = dateFormat.format(picked);
    }
  }

  final List<String> nationalities = ['Egypt'];
  final List<String> cities = [
    'Alexandria',
    'Aswan',
    'Asyut',
    'Beheira',
    'Beni Suef',
    'Cairo',
    'Dakahlia',
    'Damietta',
    'Fayoum',
    'Gharbia',
    'Giza',
    'Ismailia',
    'Kafr El Sheikh',
    'Luxor',
    'Matrouh',
    'Minya',
    'Monufia',
    'New Valley',
    'North Sinai',
    'Port Said',
    'Qalyubia',
    'Qena',
    'Red Sea',
    'Sharqia',
    'Sohag',
    'South Sinai',
    'Suez',
  ];
  final List<String> areas = [
    "Zamalek",
    "Maadi",
    "Heliopolis",
    "Dokki",
    "Al Haram",
    "6th of October",
    "Manshiya",
    "Sidi Gaber",
    "Montaza",
    "Banha",
    "Qalyub",
    "Shubra El Kheima",
    "West Asyut",
    "El Hamraa",
    "El Fath",
    "Al Awamiya",
    "El Karnak",
    "Central Luxor",
  ];
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  List<String> levels = [
    'High School',
    'Associate',
    'Bachelor',
    'Master',
    'Doctorate',
    'Professional',
  ];
  final List<String> years = List.generate(
    100,
    (index) => (DateTime.now().year - index).toString(),
  );
  int getGenderValue(String gender) {
    switch (gender) {
      case 'Male':
        return 1;
      case 'Female':
        return 2;
      default:
        throw Exception('Invalid Gender selected');
    }
  }

  String? _validateGenderSelection(String? value) {
    if (gender.isEmpty) {
      return 'Select gender';
    }
    return null;
  }

  InputDecoration getOutlinedDecoration(String label, {String? hintText}) {
    return InputDecoration(
      labelText: label,
      hintText: hintText ?? 'Please enter $label', // Show hint when no data
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    );
  }

  Widget buildLabelDropdownRow(
    String label,
    List<String> items,
    String? value,
    void Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  ' *',
                  style: TextStyle(color: AppColors.red, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 7,
            child: DropdownButtonFormField<String>(
              value: value,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
              items:
                  items
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              onChanged: onChanged,
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return '$label must not be empty';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddUpdatePersonInfoCubit>(context).getPersonalInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddUpdatePersonInfoCubit, AddUpdatePersonInfoState>(
        listener: (context, state) {
          if (state is AddUpdatePersonInfoSuccess) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.green,
                  title: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 30,
                    child: Icon(Icons.check, size: 30, color: AppColors.green),
                  ),
                  content: Text(
                    "Info Saved",
                    style: GoogleFonts.lato(textStyle: AppStyles.bold20),
                    textAlign: TextAlign.center,
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(color: AppColors.green, fontSize: 20),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is AddUpdatePersonInfoFailure) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.red,
                  title: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 30,
                    child: Icon(Icons.warning, size: 30, color: AppColors.red),
                  ),
                  content: Text(
                    state.errorMessage,
                    style: GoogleFonts.lato(textStyle: AppStyles.bold20),
                    textAlign: TextAlign.center,
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(color: AppColors.red, fontSize: 20),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is GetPersonInfoSuccess) {
            setState(() {
              firstNameController.text = state.personalInfoModel.firstName;
              lastNameControlloer.text = state.personalInfoModel.lastName;
              mobileNumberController.text = state.personalInfoModel.phoneNumber;
              birthDateController.text = state.personalInfoModel.birthDate;
              alternativemobileNumberController.text =
                  state.personalInfoModel.alternativeNumber;
              facultyController.text = state.personalInfoModel.faculty;
              universityNameController.text =
                  state.personalInfoModel.universityName;
              gender =
                  (state.personalInfoModel.gender == 'Other')
                      ? ''
                      : state.personalInfoModel.gender;
              city =
                  (state.personalInfoModel.city == '')
                      ? null
                      : state.personalInfoModel.city;
              area =
                  (state.personalInfoModel.area == '')
                      ? null
                      : state.personalInfoModel.area;
              nationality =
                  (state.personalInfoModel.country == '')
                      ? null
                      : state.personalInfoModel.country;
              level =
                  (state.personalInfoModel.level == '')
                      ? null
                      : state.personalInfoModel.level;
            });
          }
        },
        builder: (context, state) {
          if (state is GetPersonInfoSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Name *",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: firstNameController,

                            decoration: getOutlinedDecoration(
                              'First Name',
                              hintText:
                                  firstNameController.text.isEmpty
                                      ? 'Enter First name'
                                      : null,
                            ),
                            validator: (input) {
                              if (firstNameController.text.isEmpty) {
                                return 'First Name must not be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: lastNameControlloer,

                            decoration: getOutlinedDecoration(
                              'Last Name',
                              hintText:
                                  lastNameControlloer.text.isEmpty
                                      ? 'Enter Last name'
                                      : null,
                            ),
                            validator: (input) {
                              if (lastNameControlloer.text.isEmpty) {
                                return 'Last Name must not be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Text(
                      "Gender *",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColors.blue,
                      ),
                    ),
                    FormField<String>(
                      validator: _validateGenderSelection,
                      builder: (FormFieldState<String> state) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildRadioOption(value: 'Male'),
                                _buildRadioOption(value: 'Female'),
                              ],
                            ),
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  state.errorText!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: mobileNumberController,
                      decoration: getOutlinedDecoration('Mobile Number'),
                      keyboardType: TextInputType.phone,
                      validator: (input) {
                        if (mobileNumberController.text.isEmpty) {
                          return 'Mobile number must not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: alternativemobileNumberController,
                      decoration: getOutlinedDecoration(
                        'Alternative Mobile Number',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (input) {
                        if (alternativemobileNumberController.text.isEmpty) {
                          return 'Mobile number must not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Nationality, City, Area
                    buildLabelDropdownRow(
                      'Nationality',
                      nationalities,
                      nationality,
                      (val) => setState(() => nationality = val),
                    ),
                    buildLabelDropdownRow(
                      'city',
                      cities,
                      city,
                      (val) => setState(() => city = val),
                    ),
                    buildLabelDropdownRow(
                      'Area',
                      areas,
                      area,
                      (val) => setState(() => area = val),
                    ),

                    const SizedBox(height: 10),
                    const Text(
                      "Add Education",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('Level'),
                    DropdownButtonFormField<String>(
                      value: level,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                      items:
                          levels
                              .map(
                                (e) =>
                                    DropdownMenuItem(value: e, child: Text(e)),
                              )
                              .toList(),
                      onChanged: (val) => setState(() => level = val),
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Level must not be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    Text('Faculty'),
                    SizedBox(height: 10),

                    TextFormField(
                      controller: facultyController,

                      decoration: getOutlinedDecoration(
                        'Faculty',
                        hintText:
                            facultyController.text.isEmpty
                                ? 'Enter Faculty'
                                : null,
                      ),
                      validator: (input) {
                        if (facultyController.text.isEmpty) {
                          return 'Faculty must not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    Text('University Name'),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: universityNameController,

                      decoration: getOutlinedDecoration(
                        'University Name',
                        hintText:
                            firstNameController.text.isEmpty
                                ? 'Enter University Name'
                                : null,
                      ),
                      validator: (input) {
                        if (universityNameController.text.isEmpty) {
                          return 'University Name must not be empty';
                        } else {
                          return null;
                        }
                      },
                      // initialValue: companyNameController.text,
                    ),
                    SizedBox(height: 12),

                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       value: currentlyEnrolled,
                    //       onChanged:
                    //           (value) =>
                    //               setState(() => currentlyEnrolled = value!),
                    //     ),
                    //     const Text(
                    //       "Currently Enrolled",
                    //       style: TextStyle(fontSize: 16),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 10),
                    const Text(
                      "Date Of Birth",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),

                    GestureDetector(
                      onTap: () => _selectDate(context, birthDateController),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: birthDateController,
                          decoration: getOutlinedDecoration('Birth Date'),
                          validator: (input) {
                            if (birthDateController.text.isEmpty) {
                              return 'Birth Date must not be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              int genderValue = getGenderValue(gender);
                              BlocProvider.of<AddUpdatePersonInfoCubit>(
                                context,
                              ).addUpdatePersonData(
                                firstName: firstNameController.text,
                                lastName: lastNameControlloer.text,
                                country: nationality!,
                                gender: genderValue,
                                level: level!,
                                faculty: facultyController.text,
                                universityName: universityNameController.text,
                                phoneNumber: '+2${mobileNumberController.text}',
                                alternativePhoneNumber:
                                    '+2${alternativemobileNumberController.text}',
                                city: city!,
                                area: area!,
                                dateOfBirth: birthDateController.text,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            (state is AddUpdatePersonInfoLoading)
                                ? '...'
                                : "Save Changes",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is AddUpdatePersonInfoSuccess) {
            // BlocProvider.of<AddUpdateCompanyDataCubit>(context).getCompanyInfo();
            return CircularProgressIndicator();
          } else if (state is GetPersonInfoFailure) {
            return Text(state.errorMessage);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildRadioOption({required String value}) {
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
}
