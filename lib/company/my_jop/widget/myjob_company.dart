import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/company/Cubits/all%20applicants%20for%20specific%20job%20cubit/all_applicants_for_job_cubit.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/my_job_view_body_company.dart';
import 'package:shiftswift/my_job/function/my_job_app_bar.dart';

class MyJobViewCompany extends StatelessWidget {
  const MyJobViewCompany({super.key, this.jobId, this.jobModel});
  final String? jobId;
  final CompanyJobPostModel ? jobModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllSpecificApplicantsCubit(),
      child: Scaffold(
        appBar: buildMyJobAppBar(context),
        body: MyJobViewCompanyBody(jobId: jobId,jobModel: jobModel,),
      ),
    );
  }
}
