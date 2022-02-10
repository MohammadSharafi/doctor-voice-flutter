import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/cache_manager.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/home_page_widgets.dart/appBar.dart';
import '../../core/widgets/home_page_widgets.dart/drawer.dart';
import '../globalCubit/global_cubit.dart';
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
            drawer: AppDrawer(
              onSignUpTap: () {
                CacheManager().saveToken('');
                CacheManager().saveRefreshToken('');
                CacheManager().saveOTPToken('');
                Navigator.of(context).pushNamed(Login.routeName);
              },
              onAboutUsTap: () {},
              onContactUsTap: () {
                Navigator.of(context).pushNamed(ContactUs.routeName);
              },
            ),
            backgroundColor: AppColors.darkBG,
            appBar: AppBarWidget(
              title: (state is GlobalLoadedState) ? state.title : '',
              context: context,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [

                      Image.asset(
                        'assets/images/dv.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Doctor Voice',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "AImedic is a start-up studio, aiming to offer AI products in the healthcare industry. Also, training competent data scientists is a part of our mission.\n"+
                        "Our current teams are working on medical imaging, EHR analysis, smart assists, and medical NLP problems.\n"+
                        "With a belief in “Intelligence brings hope“, AImedic is going to bring hope with data-driven solutions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  @override
  void initState() {
    BlocProvider.of<GlobalCubit>(context).getTitle('About Us');
  }
}
