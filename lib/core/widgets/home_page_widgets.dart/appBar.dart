import 'package:aimedic/core/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  String title;
  BuildContext context;

  AppBarWidget({Key? key, required this.title,required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkBG,
      centerTitle: true,
      elevation: 4,
      shadowColor: Colors.black,
      actions: [

        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(6),
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            color: Colors.white12,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/images/dv.png',
            height: 34,
            width: 34,
          ),
        ),
      ],

      title: Text(
        title,
        style: GoogleFonts.yantramanav(
          textStyle: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      leading: GestureDetector(
        onTap: (){
          Scaffold.of(context).openDrawer();
        },
        child: Icon(
          Icons.menu,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
