import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/bottom_navigation_bar.dart';
<<<<<<< HEAD
import 'package:shiftswift/company/Cubits/company%20job%20posts%20cubit/company_job_posts_cubit.dart';
=======
import 'package:shiftswift/company/bottom_bar_company.dart';
>>>>>>> 35d8a23c5ddd75a89d57683a7e773e08d915a6f3
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/home/presentation/manager/home_view_cubit.dart';
import 'package:shiftswift/login/authentication%20cubit/auth_cubit.dart';
import 'package:shiftswift/login/helper/local_network.dart';
import 'package:shiftswift/login/login_home.dart';
import 'package:shiftswift/profile/Cubits/user%20info%20cubit/user_info_cubit.dart';

import 'core/service/service_locator.dart';
import 'home/data/repos/home_repo_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheIntialization();
  setupServiceLocator();
  token = CacheNetwork.getCacheData(key: cacheTokenKey);
  accType = CacheNetwork.getCacheData(key: cacheAccountTypeKey);

  if (accType == 'Member') {
    currentId = CacheNetwork.getCacheData(key: cacheMemberIdKey);
  } else if (accType == 'Company') {
    currentId = CacheNetwork.getCacheData(key: cacheCompanyIdKey);
  }

  runApp(const Shiftswift());
}

class Shiftswift extends StatelessWidget {
  const Shiftswift({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => UserInfoCubit()),
        BlocProvider(create: (context) => CompanyJobPostsCubit()),
        BlocProvider(
          create:
              (context) =>
                  HomeViewCubit(getIt.get<HomeRepoImpl>())..getAllJob(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
<<<<<<< HEAD
        home:
            (token != null && token != '')
                ? const CustomBottomNavigationBar()
                : LoginHome(),
=======
        // home :CustomBottomCompanyBar(),
    home: (token != null && token != '')
    ? (accType == 'Company'
        ? const CustomBottomCompanyBar()
        : const CustomBottomNavigationBar())
    :  LoginHome(),
>>>>>>> 35d8a23c5ddd75a89d57683a7e773e08d915a6f3
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        ),
      ),
    );
  }
}
