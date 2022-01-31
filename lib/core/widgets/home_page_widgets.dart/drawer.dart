import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aimedic/core/utils/colors.dart';

class AppDrawer extends StatelessWidget {
  Function onContactUsTap;
  Function onAboutUsTap;
  Function onSignUpTap;

  AppDrawer({
    Key? key,
    required this.onContactUsTap,
    required this.onAboutUsTap,
    required this.onSignUpTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return drawerWidget();
  }

  Widget drawerWidget() {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        color: AppColors.darkBG,
        child: Column(
        children: [
          SizedBox(height: 55,),
          Row(children: [
            SvgPicture.asset('assets/images/Iconly-Bold-Call.svg',height: 16,),
            SizedBox(width: 12,),
            Text(
              'Contact us',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),


          ],),
          SizedBox(height: 8,),
          Divider(color: Colors.white,thickness: 0.2,),
          SizedBox(height: 8,),
          Row(children: [
            SvgPicture.asset('assets/images/Iconly-Bold-Info Square.svg',height: 16,),
            SizedBox(width: 12,),
            Text(
              'About us',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),


          ],),
          SizedBox(height: 8,),
          Divider(color: Colors.white,thickness: 0.2,),
          SizedBox(height: 50,),
          Row(children: [
            SvgPicture.asset('assets/images/Logout.svg',height: 16,color: AppColors.redStatus,),
            SizedBox(width: 12,),
            Text(
              'Sign out',
              style: TextStyle(
                color: AppColors.redStatus,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),


          ],),
          SizedBox(height: 8,),

        ],
        ),
      ),
    );
  }
}
