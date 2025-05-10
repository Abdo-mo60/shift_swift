import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/home_model/job_model.dart';
import '../../data/repos/home_repo.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  HomeViewCubit(this.homeRepo) : super(HomeViewInitial());
  final HomeRepo homeRepo;
  List<JobModel> allJobs = []; // كل الوظائف الأصلية
  List<JobModel> filteredJobs = [];
  Future<void> getAllJob() async {
    emit(HomeViewLoading());
    var result = await homeRepo.getAllJob();

    result.fold(
      (fail) {
        emit(HomeViewFailure(errorMessage: fail.errorMessage));
      },
      (jobs) {
        allJobs = jobs;
        filteredJobs = jobs;
        emit(HomeViewSuccess(jobs: filteredJobs));
      },
    );
  }

  void filtter({String? sortBy, double min = 0, double max = 0}) {
    filteredJobs = allJobs;
    filteredJobs =
        filteredJobs.where((job) {
          final salary = job.jobDataModel.salary;
          return salary >= min;
        }).toList();
    filteredJobs =
        filteredJobs.where((job) {
          final salary = job.jobDataModel.salary;
          return max == 0 ? salary >= max : salary <= max;
        }).toList();
    if (sortBy == 'Latest') {
      filteredJobs.sort(
        (a, b) => b.jobDataModel.postedOn!.compareTo(a.jobDataModel.postedOn!),
      );
    } else if (sortBy == 'Oldest') {
      filteredJobs.sort(
        (a, b) => a.jobDataModel.postedOn!.compareTo(b.jobDataModel.postedOn!),
      );
    } else if (sortBy == 'Full Time' ||
        sortBy == 'Part Time' ||
        sortBy == 'Freelance') {
      filteredJobs =
          filteredJobs
              .where(
                (job) =>
                    job.jobDataModel.jobTypeTd.toLowerCase() ==
                    sortBy!.toLowerCase(),
              )
              .toList();
    } else {
      filteredJobs = filteredJobs;
    }
    emit(HomeViewSuccess(jobs: filteredJobs));
  }

  void search(String query) {
    final filteredJobs =
        allJobs.where((job) {
          return job.jobDataModel.title.toLowerCase().contains(
            query.toLowerCase(),
          );
        }).toList();
    emit(HomeViewSuccess(jobs: filteredJobs));
  }
}
