import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/view/widgets/home_view_item.dart';
import '../manager/my_job_cubit.dart';
import '../manager/my_job_state.dart';
import 'no_saved_view.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyJobCubit, MyJobState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is MyJobSuccess) {
          if (state.jobs.isEmpty) {
            return NoSavedView();
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  spacing: 16,
                  children: List.generate(state.jobs.length, (index) {
                    return HomeViewItem(job: state.jobs[index]);
                  }),
                ),
              ),
            );
          }
        } else if (state is MyJobFailure) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
