import 'package:flutter/material.dart';
import 'package:aimedic/app/home/home.dart';
import 'package:aimedic/app/login/login.dart';
import 'package:aimedic/app/otp/otp.dart';
import 'package:aimedic/core/auth_manager.dart';
import 'package:provider/provider.dart';
import 'package:aimedic/core/utils/colors.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Future<void> controlToApp() async {
    await readAuthManager.fetchUserLogin();
    if (readAuthManager.isLogin == true) {
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => OTP()));
    }
  }

  AuthenticationManager get readAuthManager =>
      context.read<AuthenticationManager>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      controlToApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDarkBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset('assets/images/dv.png',height: 90,width: 90,),
          SizedBox(height: 20,),
          Text.rich(
            TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: 'D',
                    style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w900),
                  ),
                  TextSpan(
                    text: 'octor ',
                    style: TextStyle(color: Colors.white60,fontSize: 20,fontWeight: FontWeight.w300),

                  ),
                  TextSpan(
                    text: 'V',
                    style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w900),

                  ),
                  TextSpan(
                    text: 'oice',
                    style: TextStyle(color: Colors.white60,fontSize: 20,fontWeight: FontWeight.w300),

                  ),
                ]
            ),
        ),
        ],),
      ),
    );
  }
}
