import 'package:aimedic/app/titlePages/titlePages.dart';
import 'package:aimedic/core/constants/app_colors.dart';
import 'package:custom_navigator/custom_navigation.dart';
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
import '../globalCubit/global_cubit.dart';

class HomeView extends HomeViewModel {
  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _children = [
    DashBoard(),
    TitlePages(),
    Profile(),
  ];
  Widget _page = TitlePages();
  int _currentIndex = 1;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    // final homeViewModel = Provider.of<HomeService>(context);
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return CustomScaffold(
          scaffold: Scaffold(
            drawer: AppDrawer(
              onSignUpTap: () {
                CacheManager().saveToken('');
                CacheManager().saveRefreshToken('');
                CacheManager().saveOTPToken('');
                Navigator.of(context).pushNamedAndRemoveUntil(Login.routeName,(Route<dynamic> route) => false);
                CacheManager().deleteCacheDir();
                CacheManager().deleteAppDir();
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
              title: (state is GlobalLoadedState) ? state.title : '',
              context: context,

            ),
            body: CustomNavigator(
              navigatorKey: navigatorKey,
              home: _page,
              pageRoute: PageRoutes.materialPageRoute,

            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppColors.darkBG.withOpacity(0.5),
              type: BottomNavigationBarType.fixed,
              elevation: 5,
              onTap: (index){
                navigatorKey.currentState!.maybePop();
                setState(() => _page = _children[index]);
                setState(() => _currentIndex = index);

              },
              currentIndex: (state is GlobalLoadedState) ? state.index : 1,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(((state is GlobalLoadedState) ? state.index : 1) == 0 ? 'assets/images/Iconly-Bold-Category.svg' : 'assets/images/Category.svg', width: 20,height: 20,),
                label: ''),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(((state is GlobalLoadedState) ? state.index : 1) == 1 ? 'assets/images/Iconly-Bold-Home.svg' : 'assets/images/Iconly-Light-outline-Home.svg', width: 20,height: 20,),
                    label: ''),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(((state is GlobalLoadedState) ? state.index : 1) == 2 ? 'assets/images/Iconly-Light-outline-Profile.svg' : 'assets/images/Iconly-Light-outline-Profile.svg', width: 20,height: 20,),
                    label: ''),
            ],),

          ),
          children: _children,
          onItemTap: (index){},
        );
      },
    );
  }
}
