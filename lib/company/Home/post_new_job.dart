import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shiftswift/bottom_navigation_bar.dart';
import 'package:shiftswift/company/Cubits/company%20job%20posts%20cubit/company_job_posts_cubit.dart';
import 'package:shiftswift/company/widgets/post_job_fields.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/styles.dart';
import 'package:shiftswift/profile/Cubits/add%20update%20company%20data%20cubit/add_update_company_data_cubit.dart';
import 'package:shiftswift/profile/Profile%20All/Edit%20profile/Edit_profile_home.dart';

class PostNewJob extends StatefulWidget {
  const PostNewJob({Key? key}) : super(key: key);

  @override
  State<PostNewJob> createState() => _PostNewJobPageState();
}

class _PostNewJobPageState extends State<PostNewJob> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FocusNode titleFocusNode = FocusNode(); // FocusNode for the title field
  // final FocusNode keyWordsFocusNode = FocusNode();
  String selectedJobType = '';
  String selectedLocation = '';
  String? selectedSalaryType;
  String? selectedCity;
  bool isJobTypeValid = true;
  bool isLocationValid = true;
  final GlobalKey jobTypeKey = GlobalKey();
  final GlobalKey jobLocationKey = GlobalKey();
  final ScrollController scrollController = ScrollController();

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController jobRequirementsController =
      TextEditingController();
  final TextEditingController keywordsController = TextEditingController();
  final TextEditingController jobSalaryController = TextEditingController();
  @override
  void dispose() {
    titleFocusNode.dispose();
    // keyWordsFocusNode.dispose(); // Dispose the FocusNode when no longer needed
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddUpdateCompanyDataCubit>(context).getCompanyInfo();
  }

  Future<void> fetchData() async {
    await BlocProvider.of<AddUpdateCompanyDataCubit>(context).getCompanyInfo();
  }

  @override
  Widget build(BuildContext context) {
    List<String> jobTypes = ['Full Time', 'Part Time', 'Freelance'];
    List<String> jobLocations = ['On Site', 'Remotely', 'Hybrid'];
    List<String> cities = [
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
    List<String> salaryTypes = ['Per Month', 'Per Hour', 'Contract'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post New Job'),
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<
          AddUpdateCompanyDataCubit,
          AddUpdateCompanyDataState
        >(
          listener: (context, state) {
            if (state is GetCompanyDataSuccess) {
              if (state.companyInfoModel.firstName.isEmpty) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: AppColors.red,
                      title: CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: 30,
                        child: Icon(
                          Icons.warning,
                          size: 30,
                          color: AppColors.red,
                        ),
                      ),
                      content: Text(
                        'update profile',
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => BlocProvider(
                                      create:
                                          (context) =>
                                              AddUpdateCompanyDataCubit(),
                                      child: EditProfileScreen(),
                                    ),
                              ),
                            ).then((value) => Navigator.pop(context));
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: fetchData,
              child: Form(
                key: formKey,
                child: ListView(
                  controller: scrollController,
                  children: [
                    const Text(
                      'Post New Job',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomPostJobFields(
                      label: 'Title',
                      focusNode: titleFocusNode,
                      controller: jobTitleController,
                    ),

                    const SizedBox(height: 16),
                    KeyedSubtree(
                      key: jobTypeKey,
                      child: CustomPostJobFields(
                        label: 'Job Type',
                        widget: JobOptionsSelection(
                          jobOptionsList: jobTypes,
                          initialValue: selectedJobType,
                          onOptionSelected: (value) {
                            setState(() {
                              selectedJobType = value;
                            });
                          },
                        ),
                      ),
                    ),
                    if (!isJobTypeValid)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Job type is Required',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),

                    const SizedBox(height: 16),

                    KeyedSubtree(
                      key: jobLocationKey,
                      child: CustomPostJobFields(
                        label: 'Job Locations',

                        widget: JobOptionsSelection(
                          jobOptionsList: jobLocations,
                          initialValue: selectedLocation,
                          onOptionSelected: (value) {
                            setState(() {
                              selectedLocation = value;
                            });
                          },
                        ),
                      ),
                    ),
                    if (!isLocationValid)
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'Location is required',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),

                    const SizedBox(height: 16),
                    buildLabeledField(
                      'City',
                      DropdownButtonFormField<String>(
                        menuMaxHeight: 250,
                        decoration: customInputDecoration(),
                        items:
                            cities
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        value: selectedCity,
                        onChanged: (value) {
                          setState(() => selectedCity = value);
                        },
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'City Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    //     CustomPostJobFields(
                    //   label: 'City',
                    //   widget: CustomDropdownField(
                    //     list: cities,
                    //     initialValue: selectedCity,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedCity = value;
                    //         print('selectedCity: $selectedCity');
                    //         print("Cities: $cities");
                    //       });
                    //     },
                    //   ),
                    // ),
                    buildLabeledField(
                      'Salary type',
                      DropdownButtonFormField<String>(
                        decoration: customInputDecoration(),
                        items:
                            salaryTypes
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        value: selectedSalaryType,
                        onChanged: (value) {
                          setState(() => selectedSalaryType = value);
                        },
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'Salary Type Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    // const SizedBox(height: 16),
                    // CustomPostJobFields(
                    //   label: 'Salary Type',
                    //   widget: CustomDropdownField(
                    //     list: salaryTypes,
                    //     initialValue: selectedSalaryType,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedSalaryType = value;
                    //         print('selectedSalaryType: $selectedSalaryType');
                    //         print("salaryTypes: $salaryTypes");
                    //       });
                    //     },
                    //   ),
                    // ),
                    const SizedBox(height: 16),

                    CustomPostJobFields(
                      label: 'Salary',
                      controller: jobSalaryController,
                      inputType: TextInputType.number,
                    ),

                    const SizedBox(height: 16),
                    CustomPostJobFields(
                      label: 'Job Description',
                      controller: jobDescriptionController,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 16),
                    CustomPostJobFields(
                      label: 'Job Requirements',
                      controller: jobRequirementsController,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 16),
                    CustomPostJobFields(
                      label: 'Key Words',
                      //   focusNode: keyWordsFocusNode,
                      controller: keywordsController,
                    ),

                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed:
                          (state is GetCompanyDataSuccess &&
                                  state.companyInfoModel.firstName.isEmpty)
                              ? null
                              : () async {
                                // Focus on the title field to ensure it's validated properly
                                FocusScope.of(
                                  context,
                                ).requestFocus(titleFocusNode);
                                // FocusScope.of(context).requestFocus(keyWordsFocusNode);

                                final isValid =
                                    formKey.currentState!.validate();
                                final isJobTypeSelected =
                                    selectedJobType.isNotEmpty;
                                final isLocationSelected =
                                    selectedLocation.isNotEmpty;
                                final isCitySelected = selectedCity != null;
                                final isSalaryTypeSelected =
                                    selectedSalaryType != null;

                                setState(() {
                                  isJobTypeValid = selectedJobType.isNotEmpty;
                                  isLocationValid = selectedLocation.isNotEmpty;
                                });

                                if (isValid &&
                                    isJobTypeSelected &&
                                    isLocationSelected &&
                                    isCitySelected &&
                                    isSalaryTypeSelected) {
                                  final int jobTypeValue = getJobTypeValue(
                                    selectedJobType,
                                  );
                                  final int workModeValue = getWorkModeValue(
                                    selectedLocation,
                                  );
                                  final int salaryTypeValue =
                                      getSalaryTypeValue(selectedSalaryType!);
                                  // Bloc Logic
                                  BlocProvider.of<CompanyJobPostsCubit>(
                                    context,
                                  ).createJobPostForCompany(
                                    title: jobTitleController.text,
                                    description: jobDescriptionController.text,
                                    location: selectedCity!,
                                    requirements:
                                        jobRequirementsController.text,
                                    keywords: keywordsController.text,
                                    salary:
                                        int.tryParse(jobSalaryController.text)!,
                                    salaryType: salaryTypeValue,
                                    workMode: workModeValue,
                                    jobType: jobTypeValue,
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              CustomBottomNavigationBar(),
                                    ),
                                  );
                                }
                                // else {
                                //   // Optionally, show a message indicating missing fields
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       behavior: SnackBarBehavior.floating,
                                //       content: Text('Please fill out all required fields.'),
                                //     ),
                                //   );
                                // }
                              },
                      child: const Text('Post'),
                    ),

                    // TextButton(
                    //   onPressed: () {
                    //     final isValid = _formKey.currentState!.validate();
                    //     final isJobTypeSelected = selectedJobType.isNotEmpty;
                    //     final isLocationSelected = selectedLocation.isNotEmpty;

                    //     setState(() {});

                    //     if (isValid && isJobTypeSelected && isLocationSelected) {
                    //       // Save logic here
                    //     }
                    //   },
                    //   child: const Text('Save And Post Later'),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget buildLabeledField(String label, Widget field) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(width: 10),
      Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      const SizedBox(height: 6),
      field,
    ],
  );
}

int getJobTypeValue(String jobType) {
  switch (jobType) {
    case 'Full Time':
      return 1;
    case 'Part Time':
      return 2;
    case 'Freelance':
      return 3;
    default:
      throw Exception('Invalid job type selected');
  }
}

int getWorkModeValue(String workMode) {
  switch (workMode) {
    case 'On Site':
      return 1;
    case 'Remotely':
      return 2;
    case 'Hybrid':
      return 3;
    default:
      throw Exception('Invalid work mode selected');
  }
}

int getSalaryTypeValue(String salaryType) {
  switch (salaryType) {
    case 'Per Month':
      return 1;
    case 'Per Hour':
      return 2;
    case 'Contract':
      return 3;
    default:
      throw Exception('Invalid salary type selected');
  }
}
