import 'package:aimedic/app/dashBoard/cubit/dashboard_cubit.dart';
import 'package:aimedic/app/dashBoard/dashboard.dart';
import 'package:aimedic/app/otp/cubit/otp_cubit.dart';
import 'package:aimedic/app/otp/otp.dart';
import 'package:aimedic/app/titlePages/cubit/titlePages_cubit.dart';
import 'package:aimedic/app/titlePages/titlePages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aimedic/app/splash/splash.dart';
import 'package:aimedic/core/network/network_service.dart';
import 'app/home/home.dart';
import 'app/login/cubit/login_cubit.dart';
import 'app/login/login.dart';
import 'app/profile/cubit/profile_cubit.dart';
import 'app/record/cubit/files/files_cubit.dart';
import 'app/record/cubit/record/record_cubit.dart';
import 'app/record/record.dart';
import 'app/splash/cubit/splash_cubit.dart';

final Dio dio = NetworkService.instance.dio;

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<RecordCubit>(
          create: (context) => RecordCubit(),
        ),
        BlocProvider<FilesCubit>(
          create: (context) => FilesCubit(),
        ),
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<TitlePagesCubit>(
          create: (context) => TitlePagesCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<OTPCubit>(
          create: (context) => OTPCubit(),
        ),
        BlocProvider<DashboardCubit>(
          create: (context) => DashboardCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uzel Bilisim',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashView.routeName,
      routes: {
        Record.routeName: (context) => Record(),
        SplashView.routeName: (context) => SplashView(),
        Home.routeName: (context) => Home(),
        OTP.routeName: (context) => OTP(),
        Login.routeName: (context) => Login(),
        DashBoard.routeName: (context) => DashBoard(),
        TitlePages.routeName: (context) => TitlePages(),
      },
    );
  }
}
