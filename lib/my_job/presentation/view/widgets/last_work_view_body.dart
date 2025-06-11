import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/lastwork_cubit.dart';
import '../no_saved_view.dart';
import 'last_work_view_item.dart';

class LastWorkViewBody extends StatelessWidget {
  const LastWorkViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LastworkCubit, LastworkState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LastworkSuccessful) {
          return state.jobs.isNotEmpty
              ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: List.generate(state.jobs.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: LastWorkViewItem(
                          lastWorkModel: state.jobs[index],
                        ),
                      );
                    }),
                  ),
                ),
              )
              : NoSavedView();
        } else if (state is LastworkFailure) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
