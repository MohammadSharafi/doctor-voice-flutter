import 'package:aimedic/app/globalCubit/global_cubit.dart';
import 'package:aimedic/app/titlePages/titlePages.dart';
import 'package:aimedic/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:aimedic/app/dashBoard/dashboard.dart';
import 'package:aimedic/app/home/viewModel/home_view_model.dart';
import 'package:aimedic/app/profile/profile.dart';
import 'package:aimedic/core/widgets/home_page_widgets.dart/appBar.dart';
import 'package:aimedic/core/widgets/home_page_widgets.dart/drawer.dart';

import '../../../core/cache_manager.dart';
import '../../JustView/AboutUs.dart';
import '../../JustView/ContactUs.dart';
import '../../login/login.dart';

class HomeView extends HomeViewModel {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 1;

  static List<Widget> _pages = <Widget>[
    DashBoard(),
    TitlePages(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final homeViewModel = Provider.of<HomeService>(context);
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
            onAboutUsTap: () {
              Navigator.of(context).pushNamed(AboutUs.routeName);
            },
            onContactUsTap: () {
              Navigator.of(context).pushNamed(ContactUs.routeName);
            },
          ),
          backgroundColor: AppColors.darkBG,
          appBar: AppBarWidget(
            title: (state is GlobalLoadedState) ? state.title
                : '',
            context: context,
          ),
          body: Center(
            child: _pages.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () => _onItemTapped(0),
                      child: SvgPicture.asset(
                        _selectedIndex == 0
                            ? 'assets/images/Iconly-Bold-Category.svg'
                            : 'assets/images/Category.svg',
                        height: 26,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () => _onItemTapped(1),
                      child: SvgPicture.asset(
                        _selectedIndex == 1
                            ? 'assets/images/Iconly-Bold-Home.svg'
                            : 'assets/images/Iconly-Light-outline-Home.svg',
                        height: 26,
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () => _onItemTapped(2),
                      child: SvgPicture.asset(
                        'assets/images/Iconly-Light-outline-Profile.svg',
                        height: 26,
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
