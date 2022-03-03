import 'package:aimedic/app/home/globalCubit/navigator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import '../../../core/constants/app_colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SingleChildScrollView(
        // it enables scrolling
        child: Column(
          children: [
            ResponsiveWrapper(
              maxWidth: 350,
              minWidth: 350,
              background: Container(
                color: AppColors.darkBG,
              ),
              alignment: Alignment.centerLeft,
              backgroundColor: AppColors.darkBG,
              mediaQueryData: MediaQueryData(size: Size(250, 150)),
              child: DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Container(
                            height:90,
                            width: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white70,
                                  width: 1,
                                ),
                                shape: BoxShape.circle),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/Iconly-Bold-Add User.svg',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'name',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 12,),
                              Text(
                                'Score:  23',
                                style: TextStyle(color: Colors.white54),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )),
            ),
            DrawerListTile(
              title: "Home",
              svgSrc: "assets/images/Iconly-Bold-Home.svg",
              page: PAGES.HOME,
              press: () {
                BlocProvider.of<NavigationCubit>(context).setPage(PAGES.HOME);
              },
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/images/Iconly-Bold-Category.svg",
              page: PAGES.DASHBOARD,
              press: () {
                BlocProvider.of<NavigationCubit>(context).setPage(
                    PAGES.DASHBOARD);
              },
            ),
            DrawerListTile(
              title: "Profile",
              svgSrc: "assets/images/Iconly-Light-outline-Profile.svg",
              page: PAGES.PROFILE,
              press: () {
                BlocProvider.of<NavigationCubit>(context).setPage(
                    PAGES.PROFILE);
              },
            ),
            DrawerListTile(
              title: "Contact us",
              svgSrc: "assets/images/Iconly-Bold-Call.svg",
              page: PAGES.CONTACT_US,
              press: () {
                BlocProvider.of<NavigationCubit>(context).setPage(PAGES.CONTACT_US);
              },
            ),
            DrawerListTile(
              title: "About us",
              svgSrc: "assets/images/Iconly-Bold-Info Square.svg",
              page: PAGES.ABOUT_US,
              press: () {
                BlocProvider.of<NavigationCubit>(context).setPage(PAGES.ABOUT_US);
              },
            ),

          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.page,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final PAGES page;

  @override
  Widget build(BuildContext context) {
    return  ResponsiveWrapper(
      maxWidth: 300,
      minWidth: 300,
      background: Container(
        color: AppColors.darkBG,
      ),
      alignment: Alignment.centerLeft,
      backgroundColor: AppColors.darkBG,
      mediaQueryData: MediaQueryData(size: Size(300, 100)),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Container(
            height: 90,
            color:(state is NavigationLoadedState)  ?(state.page == page)?AppColors.darkBG
                :Colors.black
                :Colors.black,
            child: Center(
              child: ListTile(
                onTap: press,
                horizontalTitleGap: 0.0,
                leading: SvgPicture.asset(
                  svgSrc,
                  color: Colors.white54,
                  height: 16,
                ),
                title: Text(
                  title,
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}