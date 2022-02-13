import 'package:aimedic/app/login/login.dart';
import 'package:aimedic/app/splash/cubit/splash_cubit.dart';
import 'package:aimedic/core/constants/app_colors.dart';
import 'package:aimedic/core/widgets/login_background.dart';
import 'package:flutter/material.dart';
import 'package:aimedic/app/home/home.dart';
import 'package:aimedic/core/auth_manager.dart';
import 'package:aimedic/core/cache_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AuthenticationManager get readAuthManager =>
      context.read<AuthenticationManager>();

  @override
  void initState() {
    super.initState();
init();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primaryDarkBlue,
      body: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Background(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Image.asset(
                    'assets/images/dv.png',
                    height: 90,
                    width: 90,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(children: <InlineSpan>[
                      TextSpan(
                        text: 'D',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      TextSpan(
                        text: 'octor ',
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                      TextSpan(
                        text: 'V',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900),
                      ),
                      TextSpan(
                        text: 'oice',
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void init() {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      final token = await CacheManager().getToken();
      if(token=='' || token==null)
        Navigator.of(context).pushNamed(Login.routeName);
      else
        Navigator.of(context).pushNamedAndRemoveUntil(Home.routeName,(Route<dynamic> route) => false);

    });
  }
}
