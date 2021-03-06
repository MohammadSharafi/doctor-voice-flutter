import 'package:aimedic/core/widgets/login_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../core/cache_manager.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/home_page_widgets.dart/appBar.dart';
import '../../core/widgets/home_page_widgets.dart/drawer.dart';
import '../../core/widgets/rounded_button_back.dart';
import '../home/globalCubit/global_cubit.dart';
import '../home/home.dart';
import '../login/login.dart';
import 'ContactUs.dart';

class AboutUs extends StatefulWidget {
  static const routeName = '/aboutUs';

  @override
  _AboutUs createState() => new _AboutUs();
}

class _AboutUs extends State<AboutUs> {
  late String title = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Scaffold(
            drawer: !kIsWeb
                ? AppDrawer(
                    onSignUpTap: () {
                      CacheManager().saveToken('');
                      CacheManager().saveRefreshToken('');
                      CacheManager().saveOTPToken('');
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Login.routeName, (Route<dynamic> route) => false);
                      CacheManager().deleteCacheDir();
                      CacheManager().deleteAppDir();
                    },
                    onAboutUsTap: () {
                      Navigator.of(context).pushNamed(AboutUs.routeName);
                    },
                    onContactUsTap: () {
                      Navigator.of(context).pushNamed(ContactUs.routeName);
                    },
                  )
                : null,
            backgroundColor: AppColors.darkBG,
            appBar: !kIsWeb
                ? AppBarWidget(
                    title: (state is GlobalLoadedState) ? state.title : '',
                    context: context,
                  )
                : null,
            body: kIsWeb
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/dv.png',
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Doctor Voice',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "AImedic is a start-up studio, aiming to offer AI products in the healthcare industry. Also, training competent data scientists is a part of our mission.\n" +
                              "Our current teams are working on medical imaging, EHR analysis, smart assists, and medical NLP problems.\n" +
                              "With a belief in ???Intelligence brings hope???, AImedic is going to bring hope with data-driven solutions",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            height: 2,
                          ),
                        ),
                        !kIsWeb ? Spacer() : Container(),
                        !kIsWeb
                            ? RoundedButtonBack(
                                press: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      Home.routeName,
                                      (Route<dynamic> route) => false);
                                },
                              )
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                : Background(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/dv.png',
                                height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Doctor Voice',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "AImedic is a start-up studio, aiming to offer AI products in the healthcare industry. Also, training competent data scientists is a part of our mission.\n" +
                                "Our current teams are working on medical imaging, EHR analysis, smart assists, and medical NLP problems.\n" +
                                "With a belief in ???Intelligence brings hope???, AImedic is going to bring hope with data-driven solutions",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              height: 2,
                            ),
                          ),
                          !kIsWeb ? Spacer() : Container(),
                          !kIsWeb
                              ? RoundedButtonBack(
                                  press: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(Home.routeName,
                                            (Route<dynamic> route) => false);
                                  },
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }

  @override
  void initState() {
    BlocProvider.of<GlobalCubit>(context).getTitle('About Us', 0);
  }
}
