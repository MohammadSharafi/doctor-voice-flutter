
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aimedic/app/dashBoard/service/dashboard_service.dart';
import 'package:aimedic/app/home/service/home_service.dart';
import 'package:aimedic/app/mainPage/service/mainPage_service.dart';
import 'package:aimedic/app/profile/service/profile_service.dart';
import 'package:aimedic/app/splash/splash.dart';
import 'package:aimedic/core/auth_manager.dart';
import 'package:aimedic/core/network/network_service.dart';
final Dio dio = NetworkService.instance.dio;

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationManager>(
          create: (context) => AuthenticationManager(context: context),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeService(dio),
        ),
        ChangeNotifierProvider(
          create: (_) => MainPageService(dio),
        ),
        ChangeNotifierProvider(
          create: (_) => DashBoardService(dio),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileService(dio),
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
      home: SplashView(),
    );
  }
}
