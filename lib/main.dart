import 'package:aimedic/app/JustView/AboutUs.dart';
import 'package:aimedic/app/JustView/ContactUs.dart';
import 'package:aimedic/app/dashBoard/cubit/dashboard_cubit.dart';
import 'package:aimedic/app/dashBoard/dashboard.dart';
import 'package:aimedic/app/home/globalCubit/navigator_cubit.dart';
import 'package:aimedic/app/otp/cubit/otp_cubit.dart';
import 'package:aimedic/app/profile/cubit/avatar_cubit.dart';
import 'package:aimedic/app/profile/service/profile_service.dart';
import 'package:aimedic/app/recordList/cubit/open_close_cubit.dart';
import 'package:aimedic/app/titlePages/titlePages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aimedic/app/splash/splash.dart';
import 'package:aimedic/core/network/network_service.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'app/OTP/service/OTP_services.dart';
import 'app/dashBoard/service/dashboard_service.dart';
import 'app/home/globalCubit/global_cubit.dart';
import 'app/home/home.dart';
import 'app/login/cubit/login_cubit.dart';
import 'app/login/login.dart';
import 'app/login/service/login_services.dart';
import 'app/otp/otp.dart';
import 'app/profile/cubit/profile_cubit.dart';
import 'app/record/cubit/files/files_cubit.dart';
import 'app/record/cubit/record/record_cubit.dart';
import 'app/record/cubit/uploadVoice/uploadvoice_cubit.dart';
import 'app/record/service/record_services.dart';
import 'app/recordList/cubit/voice_refactor_cubit.dart';
import 'app/recordList/service/voicelist_service.dart';
import 'app/splash/cubit/splash_cubit.dart';
import 'app/titlePages/cubit/texts_cubit.dart';
import 'app/titlePages/service/titlePage_service.dart';

final Dio dio = NetworkService.instance.dio;

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<RecordCubit>(
          create: (context) => RecordCubit(),
        ),
        BlocProvider<openCloseCubit>(
          create: (context) => openCloseCubit(),
        ),
        BlocProvider<VoiceUploadCubit>(
          create: (context) => VoiceUploadCubit(repository: RecordService(dio)),
        ),
        BlocProvider<FilesCubit>(
          create: (context) => FilesCubit(),
        ),
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
            repository: ProfileService(dio),
          ),
        ),
        BlocProvider<AvatarCubit>(
          create: (context) => AvatarCubit(
            repository: ProfileService(dio),
          ),
        ),
        BlocProvider<VoiceListCubit>(
          create: (context) => VoiceListCubit(
            repository: VoiceListService(dio),
          ),
        ),
        BlocProvider<TitlePagesCubit>(
          create: (context) => TitlePagesCubit(
            repository: HomeService(
              dio,
            ),
          ),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(repository: LoginService(dio)),
        ),
        BlocProvider<OTPCubit>(
          create: (context) => OTPCubit(repository:OTPService(dio) ),

        ),
        BlocProvider<DashBoardCubit>(
          create: (context) =>
              DashBoardCubit(repository: DashBoardService(dio)),
        ),
        BlocProvider<GlobalCubit>(
          create: (context) =>
              GlobalCubit(0,title: ''),
        ),
        BlocProvider<NavigationCubit>(
          create: (context) =>
              NavigationCubit(PAGES.DASHBOARD),
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
      builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          defaultScale: true,
          minWidth: 480,
          defaultName: MOBILE,
          breakpoints: [
            const ResponsiveBreakpoint.autoScale(480, name: MOBILE),
            const ResponsiveBreakpoint.resize(600, name: MOBILE),
            const ResponsiveBreakpoint.resize(850, name: TABLET),
            const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
          ],
          ),
      debugShowCheckedModeBanner: false,
      title: 'Doctor Voice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => SplashView(),
        Home.routeName: (context) => Home(),
        OTP.routeName: (context) => OTP(),
        Login.routeName: (context) => Login(),
        DashBoard.routeName: (context) => DashBoard(),
        TitlePages.routeName: (context) => TitlePages(),
        ContactUs.routeName: (context) => ContactUs(),
        AboutUs.routeName: (context) => AboutUs(),
      },
    );
  }
}
