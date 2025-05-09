import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shiftswift/core/service/api_service.dart';

import '../../home/data/repos/home_repo_impl.dart';
import '../../my_job/repos/my_job_repo_impl.dart';


final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiService>()));
  getIt.registerSingleton<MyJobRepoImpl>(
    MyJobRepoImpl(apiService: getIt.get<ApiService>()),
  );
}
