import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/service/service_locator.dart';
import '../../repos/my_job_repo_impl.dart';
import '../manager/lastwork_cubit.dart';
import 'widgets/last_work_view_body.dart';

class LastWorkView extends StatelessWidget {
  const LastWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              LastworkCubit(getIt.get<MyJobRepoImpl>())..getAllLastWork(),
      child: LastWorkViewBody(),
    );
  }
}
