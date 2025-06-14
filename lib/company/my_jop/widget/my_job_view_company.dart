import 'package:flutter/material.dart';
import 'package:shiftswift/company/models/company_job_post_model.dart';
import 'package:shiftswift/company/my_jop/widget/accepted_apllicants.dart';
import 'package:shiftswift/company/my_jop/widget/my_job_received.dart';
import 'package:shiftswift/company/my_jop/widget/my_job_shortlist.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/my_job/model/tap_bar_model.dart';
import 'package:shiftswift/my_job/presentation/view/widgets/custom_tap_bar_button.dart';

class MyJobViewCompanyBody extends StatefulWidget {
  const MyJobViewCompanyBody({super.key, this.jobId, this.jobModel});
  final String? jobId;
  final CompanyJobPostModel? jobModel;

  @override
  State<MyJobViewCompanyBody> createState() => _MyJobViewBodyState();
}

int selectedItem = 0;

class _MyJobViewBodyState extends State<MyJobViewCompanyBody> {
  @override
  Widget build(BuildContext context) {
    List<TapBarModel> tapBar = [
      TapBarModel(
        text: 'Received',
        widget: ReceivedViewCompany(
          jobId: widget.jobId,
          jobModel: widget.jobModel,
        ),
      ),
      TapBarModel(
        text: 'Short List',
        widget: ShortListPage(
          jobId: widget.jobId,
          jobPostModel: widget.jobModel,
        ),
      ),
       TapBarModel(
        text: 'Accepted',
        widget: AcceptedApllicants(
          jobId: widget.jobId,
          jobModel: widget.jobModel,
        ),
      ),
    ];
    return Column(
      children: [
        Container(
          color: AppColors.blue,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            spacing: 10,
            children: List.generate(tapBar.length, (index) {
              return Expanded(
                child: CustomTapBarButton(
                  text: tapBar[index].text,
                  isSelected: index == selectedItem,
                  onPressed: () {
                    selectedItem = index;
                    setState(() {});
                  },
                ),
              );
            }),
          ),
        ),
        Expanded(child: tapBar[selectedItem].widget),
      ],
    );
  }
}
