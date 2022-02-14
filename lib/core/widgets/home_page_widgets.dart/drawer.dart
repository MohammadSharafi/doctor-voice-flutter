import 'package:aimedic/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class AppDrawer extends StatefulWidget {
  VoidCallback onContactUsTap;
  VoidCallback onAboutUsTap;
  VoidCallback onSignUpTap;

  AppDrawer({
    Key? key,
    required this.onContactUsTap,
    required this.onAboutUsTap,
    required this.onSignUpTap,
  }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState(
      onAboutUsTap: onAboutUsTap,
      onContactUsTap: onContactUsTap,
      onSignUpTap: onSignUpTap);
}

class _AppDrawerState extends State<AppDrawer>
    with SingleTickerProviderStateMixin {
  VoidCallback onContactUsTap;
  VoidCallback onAboutUsTap;
  VoidCallback onSignUpTap;

  _AppDrawerState({
    required this.onContactUsTap,
    required this.onAboutUsTap,
    required this.onSignUpTap,
  });

  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    slideAnimation = Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: slideAnimation, child: drawerWidget());
  }

  Widget drawerWidget() {
    return WillPopScope(
      onWillPop: ()async {
        controller.reverse();
        return false;
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 12),
            color: AppColors.darkBG,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: onContactUsTap,
                  child: Container(
                    height:50 ,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Iconly-Bold-Call.svg',
                          height: 16,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Contact us',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Divider(
                  color: Colors.white.withOpacity(0.5),
                  thickness: 0.2,
                ),

                InkWell(
                  onTap: onAboutUsTap,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Iconly-Bold-Info Square.svg',
                          height: 16,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'About us',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Divider(
                  color: Colors.white.withOpacity(0.5),
                  thickness: 0.2,
                ),

                SizedBox(
                  height: 36,
                ),

                InkWell(
                  onTap: onSignUpTap,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Logout.svg',
                          height: 16,
                          color: AppColors.redStatus,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Sign out',
                          style: TextStyle(
                            color: AppColors.redStatus,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
