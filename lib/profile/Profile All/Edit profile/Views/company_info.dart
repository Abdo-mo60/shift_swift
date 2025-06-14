import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/profile/Cubits/add%20update%20company%20data%20cubit/add_update_company_data_cubit.dart';

class CompanyInfoPage extends StatefulWidget {
  const CompanyInfoPage({super.key});

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  String? nationality;
  String? city;
  String? area;

  final List<String> nationalities = ['Egypt', 'Libya', 'Iraq','UAE','Qatar','Saudia Arabia'];
  final List<String> cities = ['Cairo', "Alex", 'Sohag'];
  final List<String> areas = ['Imbaba', "Sheikh Zayed", '6th Octobor'];

  final firstNameController = TextEditingController();
  final lastNameControlloer = TextEditingController();
  final mobileNumberController = TextEditingController();
  final overViewController = TextEditingController();
  final fieldController = TextEditingController();
  final dateOfEstablishController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = dateFormat.format(picked);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddUpdateCompanyDataCubit>(context).getCompanyInfo();
  }

  // Update the decoration function to show hint text when there is no data
  InputDecoration getOutlinedDecoration(String label, {String? hintText}) {
    return InputDecoration(
      labelText: label,
      hintText: hintText ?? 'Please enter $label', // Show hint when no data
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddUpdateCompanyDataCubit, AddUpdateCompanyDataState>(
        listener: (context, state) {
          if (state is AddUpdateCompanyDataSuccess) {
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
          } else if (state is AddUpdateCompanyDataFailure) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.red,
                  title: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 30,
                    child: Icon(Icons.check, size: 30, color: AppColors.red),
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
          } else if (state is GetCompanyDataSuccess) {
            setState(() {
              firstNameController.text = state.companyInfoModel.firstName;
              lastNameControlloer.text = state.companyInfoModel.lastName;
              mobileNumberController.text = state.companyInfoModel.phoneNumber;
              overViewController.text = state.companyInfoModel.overview;
              fieldController.text = state.companyInfoModel.field;
              dateOfEstablishController.text =
                  state.companyInfoModel.dateOfEstablish;
              nationality =
                  (state.companyInfoModel.country == '')
                      ? null
                      : state.companyInfoModel.country;
              city =
                  (state.companyInfoModel.city == '')
                      ? null
                      : state.companyInfoModel.city;
              area =
                  (state.companyInfoModel.area == '')
                      ? null
                      : state.companyInfoModel.area;
            });
          }
        },
        builder: (context, state) {
          if (state is GetCompanyDataSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Your Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.blue,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          ' *',
                          style: TextStyle(color: AppColors.red, fontSize: 18),
                        ),
                      ],
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
                    const SizedBox(height: 30),
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
                    SizedBox(height: 15),

                    TextFormField(
                      controller: overViewController,
                      decoration: getOutlinedDecoration('OverView'),
                      validator: (input) {
                        if (overViewController.text.isEmpty) {
                          return 'OverView must not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: fieldController,
                      decoration: getOutlinedDecoration('Field'),
                      validator: (input) {
                        if (fieldController.text.isEmpty) {
                          return 'Field must not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 15),

                    GestureDetector(
                      onTap:
                          () => _selectDate(context, dateOfEstablishController),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: dateOfEstablishController,
                          decoration: getOutlinedDecoration(
                            'Date Of Esatblish',
                          ),
                          validator: (input) {
                            if (dateOfEstablishController.text.isEmpty) {
                              return 'Date of Establish must not be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Nationality, City, Area
                    buildLabelDropdownRow(
                      'Your Loctaion',
                      nationalities,
                      nationality,
                      (val) => setState(() => nationality = val),
                    ),
                    buildLabelDropdownRow(
                      'City',
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

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Proceed with submission
                              BlocProvider.of<AddUpdateCompanyDataCubit>(
                                context,
                              ).addUpdateCompanyData(
                                firstName: firstNameController.text,
                                lastName: lastNameControlloer.text,
                                phoneNumber: mobileNumberController.text,
                                country: nationality!,
                                city: city!,
                                area: area!,
                                field: fieldController.text,
                                overView: overViewController.text,
                                dateOfEstablish: dateOfEstablishController.text,
                              );
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            (state is AddUpdateCompanyDataLoading)
                                ? "..."
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
          } else if (state is GetCompanyDataFailure) {
            return Text(state.errorMessage);
          } else if (state is AddUpdateCompanyDataSuccess) {
            return CircularProgressIndicator();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
