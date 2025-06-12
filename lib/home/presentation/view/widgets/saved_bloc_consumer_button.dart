import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/core/app_colors.dart';
import '../../manager/added_job_cubit.dart';
import 'custom_button.dart';
import 'ids.dart';

class SavedBlocConsumerButton extends StatelessWidget {
  const SavedBlocConsumerButton({super.key, required this.jobId});

  final String jobId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Addedjobcubit, AddedjobState>(
      listener: (context, state) {
        if (state is AddedjobcubitSuccess) {
          log(state.jobAddedModel.message!);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.jobAddedModel.message!)));
        }
        if (state is AddedjobcubitFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Job is already saved'),
              backgroundColor: AppColors.blue,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          text: 'Save',
          isIcon: true,
          onTap: () {
            BlocProvider.of<Addedjobcubit>(
              context,
            ).savedJob(jobId: jobId, memberId: Ids.memberId);
          },
        );
      },
    );
  }
}
