import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/home_view_cubit.dart';
import 'home_view_item.dart';

class HomeViewItemColumn extends StatelessWidget {
  const HomeViewItemColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewCubit, HomeViewState>(
      builder: (context, state) {
        if (state is HomeViewSuccess) {
          return Column(
            children: List.generate(state.jobs.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: HomeViewItem(job: state.jobs[index]),
              );
            }),
          );
        } else if (state is HomeViewFailure) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
