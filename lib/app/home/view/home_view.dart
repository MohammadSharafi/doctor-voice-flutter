import 'package:aimedic/app/dashBoard/view/dashboard_view.dart';
import 'package:aimedic/app/titlePages/titlePages.dart';
import 'package:aimedic/core/constants/app_colors.dart';
import 'package:custom_navigator/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:aimedic/app/dashBoard/dashboard.dart';
import 'package:aimedic/app/home/viewModel/home_view_model.dart';
import 'package:aimedic/app/profile/profile.dart';
import 'package:aimedic/core/widgets/home_page_widgets.dart/appBar.dart';
import 'package:aimedic/core/widgets/home_page_widgets.dart/drawer.dart';

import '../../../core/cache_manager.dart';
import '../../JustView/AboutUs.dart';
import '../../JustView/ContactUs.dart';
import '../../login/login.dart';
import '../../profile/view/profile_view.dart';
import '../../recordPage/recordpage.dart';
import '../../titlePages/model/ScreenArguments.dart';
import '../../titlePages/view/titlePages_view.dart';
import '../globalCubit/global_cubit.dart';
import '../globalCubit/navigator_cubit.dart';
import '../viewModel/side_menu.dart';

class HomeView extends HomeViewModel {
  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    DashBoardView().dispose();
    ProfileView().dispose();
    TitlePagesView().dispose();

    super.dispose();
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
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, navigateState) {
        if(navigateState is InitialStateNav)
          {
            BlocProvider.of<NavigationCubit>(context).setPage(PAGES.HOME);
          }
        return Scaffold(
          backgroundColor: AppColors.darkBG,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: kIsWeb
                    ? Container(
                        child: (navigateState is NavigationLoadedState)
                            ? PageViewNavigator(navigateState.page,
                                navigateState.screenArguments)
                            : Container(),
                      )
                    : BlocBuilder<GlobalCubit, GlobalState>(
                        builder: (context, state) {
                          return CustomScaffold(
                            scaffold: Scaffold(
                              resizeToAvoidBottomInset: false,
                              drawer: AppDrawer(
                                onSignUpTap: () {
                                  CacheManager().saveToken('');
                                  CacheManager().saveRefreshToken('');
                                  CacheManager().saveOTPToken('');
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      Login.routeName,
                                      (Route<dynamic> route) => false);
                                  CacheManager().deleteCacheDir();
                                  CacheManager().deleteAppDir();
                                },
                                onAboutUsTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AboutUs.routeName);
                                },
                                onContactUsTap: () {
                                  Navigator.of(context)
                                      .pushNamed(ContactUs.routeName);
                                },
                              ),
                              backgroundColor: AppColors.darkBG,
                              appBar: AppBarWidget(
                                title: (state is GlobalLoadedState)
                                    ? state.title
                                    : '',
                                context: context,
                              ),
                              body: CustomNavigator(
                                navigatorKey: navigatorKey,
                                home: _page,
                                pageRoute: PageRoutes.materialPageRoute,
                              ),
                              bottomNavigationBar: BottomNavigationBar(
                                backgroundColor:
                                    AppColors.darkBG.withOpacity(0.5),
                                type: BottomNavigationBarType.fixed,
                                enableFeedback: false,
                                unselectedFontSize: 0,
                                selectedFontSize: 0,
                                elevation: 0.5,
                                onTap: (index) {
                                  navigatorKey.currentState!.maybePop();
                                  setState(() => _page = _children[index]);
                                  setState(() => _currentIndex = index);
                                },
                                currentIndex: (state is GlobalLoadedState)
                                    ? state.index
                                    : 1,
                                showSelectedLabels: false,
                                showUnselectedLabels: false,
                                items: [
                                  BottomNavigationBarItem(
                                    icon: SvgPicture.asset(
                                      ((state is GlobalLoadedState)
                                                  ? state.index
                                                  : 1) ==
                                              0
                                          ? 'assets/images/Iconly-Bold-Category.svg'
                                          : 'assets/images/Category.svg',
                                      width: 28,
                                      height: 28,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                    label: '',
                                  ),
                                  BottomNavigationBarItem(
                                      icon: SvgPicture.asset(
                                        ((state is GlobalLoadedState)
                                                    ? state.index
                                                    : 1) ==
                                                1
                                            ? 'assets/images/Iconly-Bold-Home.svg'
                                            : 'assets/images/Iconly-Light-outline-Home.svg',
                                        width: 28,
                                        height: 28,
                                        alignment: Alignment.bottomCenter,
                                      ),
                                      label: ''),
                                  BottomNavigationBarItem(
                                      icon: SvgPicture.asset(
                                        ((state is GlobalLoadedState)
                                                    ? state.index
                                                    : 1) ==
                                                2
                                            ? 'assets/images/Iconly-Light-outline-Profile.svg'
                                            : 'assets/images/Iconly-Light-outline-Profile.svg',
                                        width: 28,
                                        height: 28,
                                        alignment: Alignment.bottomCenter,
                                      ),
                                      label: ''),
                                ],
                              ),
                            ),
                            children: _children,
                            onItemTap: (index) {
                              switch (index) {
                                case 0:
                                  BlocProvider.of<GlobalCubit>(context)
                                      .getTitle('Dashboard', 0);
                                  break;
                                case 1:
                                  BlocProvider.of<GlobalCubit>(context)
                                      .getTitle('Text List', 1);
                                  break;
                                case 2:
                                  BlocProvider.of<GlobalCubit>(context)
                                      .getTitle('Profile', 2);
                                  break;
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

PageViewNavigator(PAGES page, ScreenArguments arguments) {
  print(arguments);
  switch (page) {
    case PAGES.DASHBOARD:
      return DashBoard();
    case PAGES.PROFILE:
      return Profile();
    case PAGES.HOME:
      return TitlePages();
    case PAGES.ABOUT_US:
      return AboutUs();
    case PAGES.CONTACT_US:
      return ContactUs();
    case PAGES.VOICE:
      return RecorderPage(
        args: ScreenArguments(arguments.title, arguments.id, arguments.index),
      );
    default:
      return TitlePages();
  }
}
