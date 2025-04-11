import 'package:flutter/material.dart';
import 'package:shiftswift/company/my_jop/widget/my_jop_view_company.dart';
import 'package:shiftswift/my_job/function/my_job_app_bar.dart';


class MyJobViewCompany extends StatelessWidget {
  const MyJobViewCompany ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: buildMyJobAppBar(context), body: MyJobViewCompanyBody());
  }
}
