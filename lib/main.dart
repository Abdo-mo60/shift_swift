import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shiftswift/bottom_navigation_bar.dart';
import 'package:shiftswift/constant.dart';
import 'package:shiftswift/core/app_colors.dart';
import 'package:shiftswift/login/authentication%20cubit/auth_cubit.dart';
import 'package:shiftswift/login/helper/local_network.dart';
import 'package:shiftswift/login/login_home.dart';
import 'package:shiftswift/profile/Profile%20All/profile_home.dart';
import 'package:shiftswift/profile/user%20info%20cubit/user_info_cubit.dart';
import 'package:shiftswift/splash/one_splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await CacheNetwork.cacheIntialization();
 token=CacheNetwork.getCacheData(key: cacheTokenKey);
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        home:(token!= null&& token!='')? CustomBottomNavigationBar():OneSolash(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
        ),
      ),
    );
  }
}
