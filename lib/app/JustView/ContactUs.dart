import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/cache_manager.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/home_page_widgets.dart/appBar.dart';
import '../../core/widgets/home_page_widgets.dart/drawer.dart';
import '../../core/widgets/login_background.dart';
import '../../core/widgets/rounded_button_back.dart';
import '../home/globalCubit/global_cubit.dart';
import '../home/home.dart';
import '../login/login.dart';
import 'AboutUs.dart';

class ContactUs extends StatefulWidget {
  static const routeName = '/ContactUs';

  @override
  _ContactUs createState() => new _ContactUs();
}

class _ContactUs extends State<ContactUs> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Scaffold(
            drawer: AppDrawer(
              onSignUpTap: () {
                CacheManager().saveToken('');
                CacheManager().saveRefreshToken('');
                CacheManager().saveOTPToken('');
                Navigator.of(context).pushNamed(Login.routeName);
              },
              onContactUsTap: () {
                Navigator.of(context).pushNamed(AboutUs.routeName);
              },
              onAboutUsTap: () {},
            ),
            backgroundColor: AppColors.darkBG,
            appBar: AppBarWidget(
              title: (state is GlobalLoadedState) ? state.title : '',
              context: context,
            ),
            body: Background(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/dv.png',
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Doctor Voice',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "AImedic is a start-up studio, aiming to offer AI products in the healthcare industry. Also, training competent data scientists is a part of our mission.\n"+
                      "Our current teams are working on medical imaging, EHR analysis, smart assists, and medical NLP problems.\n"+
                    "With a belief in “Intelligence brings hope“, AImedic is going to bring hope with data-driven solutions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Iconly-Bold-Call.svg',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Supporter',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '021-65659005 / 021-65659005',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Iconly-Bold-Message.svg',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'tahry88585@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Iconly-Bold-Location.svg',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Address',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Azadi St., intersection of Dr. Gharib, No. 134 Tehran, Iran',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Spacer(),
                    RoundedButtonBack(press: (){Navigator.of(context).pushNamed(Home.routeName);},),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  void initState() {
    BlocProvider.of<GlobalCubit>(context).getTitle('Contact Us',0);
  }
}
