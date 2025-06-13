import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/bottom_navigation_bar.dart';
import 'package:shiftswift/company/Cubits/company%20job%20posts%20cubit/company_job_posts_cubit.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/core/service/service_locator.dart';
import 'package:shiftswift/home/data/repos/home_repo_impl.dart';
import 'package:shiftswift/home/presentation/manager/home_view_cubit.dart';
import 'package:shiftswift/login/authentication%20cubit/auth_cubit.dart';
import 'package:shiftswift/login/helper/local_network.dart';
import 'package:shiftswift/login/login_home.dart';
import 'package:shiftswift/profile/Cubits/user%20info%20cubit/user_info_cubit.dart';
import 'package:shiftswift/splash/animation_logo.dart';
import 'package:shiftswift/splash/one_splash.dart';

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
        
        home:
            (token != null && token != '')
                ? const CustomBottomNavigationBar()
                : OneSplash(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        ),
      ),
    );
  }
}
